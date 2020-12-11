/*
 * Copyright (C) 2020 Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

#include "text_node.h"
#include "foundation/ui_command_queue.h"
#include "foundation/ui_command_callback_queue.h"

namespace kraken::binding::jsc {

void bindTextNode(std::unique_ptr<JSContext> &context) {
  auto textNode = JSTextNode::instance(context.get());
  JSC_GLOBAL_SET_PROPERTY(context, "TextNode", textNode->classObject);
}

std::unordered_map<JSContext *, JSTextNode *> JSTextNode::instanceMap{};

JSTextNode *JSTextNode::instance(JSContext *context) {
  if (instanceMap.count(context) == 0) {
    instanceMap[context] = new JSTextNode(context);
  }
  return instanceMap[context];
}
JSTextNode::~JSTextNode() {
  instanceMap.erase(context);
}

JSTextNode::JSTextNode(JSContext *context) : JSNode(context, "TextNode") {}

JSObjectRef JSTextNode::instanceConstructor(JSContextRef ctx, JSObjectRef constructor, size_t argumentCount,
                                            const JSValueRef *arguments, JSValueRef *exception) {
  const JSValueRef dataValueRef = arguments[0];
  auto textNode = new TextNodeInstance(this, JSValueToStringCopy(ctx, dataValueRef, exception));
  return textNode->object;
}

JSTextNode::TextNodeInstance::TextNodeInstance(JSTextNode *jsTextNode, JSStringRef data)
  : NodeInstance(jsTextNode, NodeType::TEXT_NODE), nativeTextNode(new NativeTextNode(nativeNode)) {

  m_data.setString(data);

  std::string dataString = JSStringToStdString(data);
  NativeString args_01{};
  buildUICommandArgs(dataString, args_01);
  foundation::UICommandTaskMessageQueue::instance(_hostClass->contextId)
    ->registerCommand(eventTargetId, UICommand::createTextNode, args_01, nativeTextNode);
}

JSValueRef JSTextNode::TextNodeInstance::getProperty(std::string &name, JSValueRef *exception) {
  auto propertyMap = getTextNodePropertyMap();

  if (propertyMap.count(name) == 0) {
    return JSNode::NodeInstance::getProperty(name, exception);
  }

  auto property = propertyMap[name];
  switch (property) {
  case TextNodeProperty::kTextContent:
  case TextNodeProperty::kData: {
    return m_data.makeString();
  }
  case TextNodeProperty::kNodeName: {
    JSStringRef nodeName = JSStringCreateWithUTF8CString("#text");
    return JSValueMakeString(_hostClass->ctx, nodeName);
  }
  }
}

void JSTextNode::TextNodeInstance::setProperty(std::string &name, JSValueRef value, JSValueRef *exception) {
  if (name == "data") {
    JSStringRef data = JSValueToStringCopy(_hostClass->ctx, value, exception);
    m_data.setString(data);

    std::string dataString = JSStringToStdString(data);
    NativeString args_01{};
    NativeString args_02{};
    buildUICommandArgs(name, dataString, args_01, args_02);
    foundation::UICommandTaskMessageQueue::instance(_hostClass->contextId)
      ->registerCommand(eventTargetId, UICommand::setProperty, args_01, args_02, nullptr);
  } else {
    JSNode::NodeInstance::setProperty(name, value, exception);
  }
}

std::array<JSStringRef, 3> &JSTextNode::TextNodeInstance::getTextNodePropertyNames() {
  static std::array<JSStringRef, 3> propertyNames{JSStringCreateWithUTF8CString("data"),
                                                  JSStringCreateWithUTF8CString("textContent"),
                                                  JSStringCreateWithUTF8CString("nodeName")};
  return propertyNames;
}

void JSTextNode::TextNodeInstance::getPropertyNames(JSPropertyNameAccumulatorRef accumulator) {
  NodeInstance::getPropertyNames(accumulator);

  for (auto &property : getTextNodePropertyNames()) {
    JSPropertyNameAccumulatorAddName(accumulator, property);
  }
}

std::string JSTextNode::TextNodeInstance::internalGetTextContent() {
  return m_data.string();
}

const std::unordered_map<std::string, JSTextNode::TextNodeInstance::TextNodeProperty> &
JSTextNode::TextNodeInstance::getTextNodePropertyMap() {
  static const std::unordered_map<std::string, TextNodeProperty> nodeProperty{
    {"data", TextNodeProperty::kData},
    {"textContent", TextNodeProperty::kTextContent},
    {"nodeName", TextNodeProperty::kNodeName}};
  return nodeProperty;
}

JSTextNode::TextNodeInstance::~TextNodeInstance() {
  foundation::UICommandCallbackQueue::instance(contextId)->registerCallback([](void *ptr) {
    delete reinterpret_cast<NativeTextNode *>(ptr);
  }, nativeTextNode);
}

void JSTextNode::TextNodeInstance::internalSetTextContent(JSStringRef content, JSValueRef *exception) {
  m_data.setString(content);

  std::string key = "data";
  NativeString args_01{};
  NativeString args_02{};
  buildUICommandArgs(key, content, args_01, args_02);
  foundation::UICommandTaskMessageQueue::instance(context->getContextId())
    ->registerCommand(eventTargetId, UICommand::setProperty, args_01, args_02, nullptr);
}

} // namespace kraken::binding::jsc