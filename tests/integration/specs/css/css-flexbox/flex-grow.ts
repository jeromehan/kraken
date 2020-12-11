/*auto generated*/
describe('flex-grow', () => {
  it('002', async () => {
    let p;
    let test1;
    let test2;
    let test3;
    let container;
    let cover;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        id: 'container',
        style: {
          'background-color': 'red',
          display: 'flex',
          height: '100px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test1 = createElement('div', {
          id: 'test1',
          style: {
            height: '100px',
            width: '20px',
            'background-color': 'green',
            'flex-grow': '1',
            'box-sizing': 'border-box',
          },
        })),
        (test2 = createElement('div', {
          id: 'test2',
          style: {
            height: '100px',
            width: '20px',
            'background-color': 'green',
            'flex-grow': '0',
            'box-sizing': 'border-box',
          },
        })),
        (test3 = createElement('div', {
          id: 'test3',
          style: {
            height: '100px',
            width: '20px',
            'box-sizing': 'border-box',
          },
        })),
      ]
    );
    cover = createElement('div', {
      id: 'cover',
      style: {
        position: 'relative',
        'background-color': 'green',
        height: '100px',
        'margin-left': '80px',
        top: '-100px',
        width: '20px',
        'box-sizing': 'border-box',
      },
    });
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(cover);

    await matchViewportSnapshot();
  });
  it('003', async () => {
    let p;
    let test1;
    let test2;
    let container;
    let cover;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        id: 'container',
        style: {
          'background-color': 'green',
          display: 'flex',
          height: '100px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test1 = createElement('div', {
          id: 'test1',
          style: {
            'background-color': 'red',
            height: '100px',
            'flex-grow': '-2',
            width: '25px',
            'box-sizing': 'border-box',
          },
        })),
        (test2 = createElement('div', {
          id: 'test2',
          style: {
            'background-color': 'red',
            height: '100px',
            'flex-grow': '-3',
            width: '25px',
            'box-sizing': 'border-box',
          },
        })),
      ]
    );
    cover = createElement('div', {
      id: 'cover',
      style: {
        'background-color': 'green',
        height: '100px',
        position: 'relative',
        top: '-100px',
        width: '50px',
        'box-sizing': 'border-box',
      },
    });
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(cover);

    await matchViewportSnapshot();
  });
  it('001', async () => {
    let child1;
    let child2;
    let child3;
    let container;
    container = createElement(
      'div',
      {
        xmlns: 'http://www.w3.org/1999/xhtml',
        id: 'container',
        style: {
          width: '240px',
          height: '60px',
          border: '#000 solid 1px',
          display: 'flex',
        },
      },
      [
        (child1 = createElement('div', {
          id: 'child_1',
          style: {
            width: '30px',
            height: '60px',
            'flex-grow': '0',
            'background-color': 'green',
          },
        })),
        (child2 = createElement('div', {
          id: 'child_2',
          style: {
            width: '30px',
            height: '60px',
            'flex-grow': '1',
            'background-color': 'blue',
          },
        })),
        (child3 = createElement('div', {
          id: 'child_3',
          style: {
            width: '30px',
            height: '60px',
            'flex-grow': '2',
            'background-color': 'gray',
          },
        })),
      ]
    );
    BODY.appendChild(container);

    await matchViewportSnapshot();
  });
  it('004', async () => {
    let p;
    let test1;
    let test2;
    let container;
    let cover;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        id: 'container',
        style: {
          'background-color': 'red',
          display: 'flex',
          height: '100px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test1 = createElement('div', {
          id: 'test1',
          style: {
            height: '100px',
            'flex-grow': '3',
            width: '50px',
            'box-sizing': 'border-box',
          },
        })),
        (test2 = createElement('div', {
          id: 'test2',
          style: {
            height: '100px',
            'background-color': 'green',
            'flex-grow': '2',
            width: '50px',
            'box-sizing': 'border-box',
          },
        })),
      ]
    );
    cover = createElement('div', {
      id: 'cover',
      style: {
        'background-color': 'green',
        height: '100px',
        position: 'relative',
        top: '-100px',
        width: '50px',
        'box-sizing': 'border-box',
      },
    });
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(cover);

    await matchViewportSnapshot();
  });
  it('005', async () => {
    let p;
    let container;
    let cover;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        id: 'container',
        style: {
          'background-color': 'green',
          display: 'flex',
          'flex-grow': '2',
          height: '100px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        createElement('div', {
          style: {
            'background-color': 'red',
            height: '100px',
            width: '25px',
            'box-sizing': 'border-box',
          },
        }),
        createElement('div', {
          style: {
            'background-color': 'red',
            height: '100px',
            width: '25px',
            'box-sizing': 'border-box',
          },
        }),
      ]
    );
    cover = createElement('div', {
      id: 'cover',
      style: {
        'background-color': 'green',
        height: '100px',
        position: 'relative',
        top: '-100px',
        width: '50px',
        'box-sizing': 'border-box',
      },
    });
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(cover);

    await matchViewportSnapshot();
  });
  it('006', async () => {
    let p;
    let test1;
    let container;
    let container_1;
    let test2;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        class: 'container',
        style: {
          'background-color': 'red',
          display: 'flex',
          height: '50px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test1 = createElement('div', {
          id: 'test1',
          style: {
            'background-color': 'green',
            height: '50px',
            width: '25px',
            'flex-grow': '1.5',
            'box-sizing': 'border-box',
          },
        })),
      ]
    );
    container_1 = createElement(
      'div',
      {
        class: 'container',
        style: {
          'background-color': 'red',
          display: 'flex',
          height: '50px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test2 = createElement('div', {
          id: 'test2',
          style: {
            'background-color': 'green',
            height: '50px',
            width: '25px',
            'flex-grow': '2',
            'box-sizing': 'border-box',
          },
        })),
      ]
    );
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(container_1);

    await matchViewportSnapshot();
  });
  it('007', async () => {
    let p;
    let test1;
    let container;
    let container_1;
    let test2;
    p = createElement(
      'p',
      {
        style: {
          'box-sizing': 'border-box',
        },
      },
      [
        createText(`Test passes if there is a filled green square and `),
        createElement(
          'strong',
          {
            style: {
              'box-sizing': 'border-box',
            },
          },
          [createText(`no red`)]
        ),
        createText(`.`),
      ]
    );
    container = createElement(
      'div',
      {
        class: 'container',
        style: {
          background: 'red',
          height: '50px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test1 = createElement(
          'div',
          {
            id: 'test1',
            style: {
              display: 'flex',
              width: '190px',
              'box-sizing': 'border-box',
            },
          },
          [
            createElement('div', {
              style: {
                background: 'green',
                height: '50px',
                'flex-grow': '0.1',
                width: '90px',
                'box-sizing': 'border-box',
              },
            }),
          ]
        )),
      ]
    );
    container_1 = createElement(
      'div',
      {
        class: 'container',
        style: {
          background: 'red',
          height: '50px',
          width: '100px',
          'box-sizing': 'border-box',
        },
      },
      [
        (test2 = createElement(
          'div',
          {
            id: 'test2',
            style: {
              display: 'flex',
              width: '190px',
              'box-sizing': 'border-box',
            },
          },
          [
            createElement('div', {
              style: {
                background: 'green',
                height: '50px',
                'flex-grow': '0.05',
                width: '45px',
                'box-sizing': 'border-box',
              },
            }),
            createElement('div', {
              style: {
                background: 'green',
                height: '50px',
                'flex-grow': '0.05',
                width: '45px',
                'box-sizing': 'border-box',
              },
            }),
          ]
        )),
      ]
    );
    BODY.appendChild(p);
    BODY.appendChild(container);
    BODY.appendChild(container_1);

    await matchViewportSnapshot();
  });
});