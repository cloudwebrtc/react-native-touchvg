# react-native-touchvg
TouchVG for React Native

# Usage

```javascript
import React, { Component } from 'react';
import {View,} from 'react-native';
import { TouchVGView } from 'react-native-touchvg';

class App extends Component {

constructor(props) {
    super(props);
    this.state = {
      command: 'splines', /*Other commands:  select | erase | rect | ellipse |  triangle | line */
    }
  }

render() {
    return (
      <View style={{backgroundColor: '#fff'}}>
        <TouchVGView
          command={this.state.command}
          style={{ width: '100%', height: '100%', alignSelf: 'center' }} />
      </View>
    );
  }
}
```

# NOTE
Based on https://github.com/rhcad/TouchVG projects.
