//
//  Shader.fsh
//  TestOpenGL
//
//  Created by KaiKai on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
