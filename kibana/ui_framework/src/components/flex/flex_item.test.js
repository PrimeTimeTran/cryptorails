'use strict';

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var _enzyme = require('enzyme');

var _required_props = require('../../test/required_props');

var _flex_item = require('./flex_item');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('KuiFlexItem', () => {
  test('is rendered', () => {
    const component = (0, _enzyme.render)(_react2.default.createElement(_flex_item.KuiFlexItem, _required_props.requiredProps));

    expect(component).toMatchSnapshot();
  });
});
