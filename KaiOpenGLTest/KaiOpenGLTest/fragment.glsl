varying lowp vec4 DestinationColor;

void main()
{
	gl_FragColor = DestinationColor;
	
	
//	lowp float c = 0.0;
//	lowp float scaledS;
//	lowp vec4 SinColor, finalColor, BackColor;
//	SinColor = vec4(1.0, 0.0, 0.0, 1.0);
//	BackColor = vec4(1.0, 1.0, 0.0, 1.0);
//	lowp float radians = Varying TexCoord0.s * 2.0 * C_PI;
//	scaledS = (sin(radians) + 1.0 ) / 2.0;
//	lowp float scaledT = (Varying TexCoord0.t * 1.02) - 0.01;
//	if(abs(scaledT - scaledS) <= 0.01)
//	{
//		c = (abs(scaledT - scaledS) * 100.0);
//		finalColor = mix( SinColor, BackColor, c);
//	}
//	else
//	{
//		finalColor = BackColor;
//	}
//		   
//	gl_FragColor = finalColor;
}

