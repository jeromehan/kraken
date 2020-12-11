/*
 * Copyright (C) 2020 Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

#include "ui_command_queue.h"
#include "dart_methods.h"

namespace foundation {

UICommandTaskMessageQueue::UICommandTaskMessageQueue(int32_t contextId) : contextId(contextId) {}

void UICommandTaskMessageQueue::registerCommand(int32_t id, int32_t type, void *nativePtr) {
  if (!update_batched) {
    kraken::getDartMethod()->requestBatchUpdate(contextId);
    update_batched = true;
  }

  UICommandItem item{id, type, nativePtr};
  queue.emplace_back(item);
}

void UICommandTaskMessageQueue::registerCommand(int32_t id, int32_t type, NativeString &args_01, void *nativePtr) {
  if (!update_batched) {
    kraken::getDartMethod()->requestBatchUpdate(contextId);
    update_batched = true;
  }

  UICommandItem item{id, type, args_01, nativePtr};
  queue.emplace_back(item);
}

void UICommandTaskMessageQueue::registerCommand(int32_t id, int32_t type, NativeString &args_01, NativeString &args_02,
                                                void *nativePtr) {
  if (!update_batched) {
    kraken::getDartMethod()->requestBatchUpdate(contextId);
    update_batched = true;
  }
  UICommandItem item{id, type, args_01, args_02, nativePtr};
  queue.emplace_back(item);
}

UICommandTaskMessageQueue *UICommandTaskMessageQueue::instance(int32_t contextId) {
  static std::unordered_map<int32_t, UICommandTaskMessageQueue *> instanceMap;

  if (instanceMap.count(contextId) == 0) {
    instanceMap[contextId] = new UICommandTaskMessageQueue(contextId);
  }

  return instanceMap[contextId];
}

UICommandItem *UICommandTaskMessageQueue::data() {
  return queue.data();
}

int64_t UICommandTaskMessageQueue::size() {
  return queue.size();
}

void UICommandTaskMessageQueue::clear() {
  for (auto command : queue) {
    delete[] command.string_01;
    delete[] command.string_02;
  }
  queue.clear();
  update_batched = false;
}

} // namespace foundation