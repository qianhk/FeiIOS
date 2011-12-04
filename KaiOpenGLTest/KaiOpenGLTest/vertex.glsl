attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;

//uniform mat4 Projection;
//uniform mat4 Modelview;

void main(void)
{
//	gl_TexCoord[0] = gl_MultiTexCoord0;
	DestinationColor = SourceColor;
	gl_Position = Position;
	//gl_Position = Projection * Modelview * Position;
}