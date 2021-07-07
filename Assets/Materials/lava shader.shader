// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "lava shader"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Color0("Color 0", Color) = (1,0.380561,0,0)
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Float3("Float 3", Range( 0 , 1)) = 0
		_Float2("Float 2", Float) = 0
		_Vector0("Vector 0", Vector) = (8,8,0,0)
		_Vector1("Vector 1", Vector) = (0.3,1,0.3,0)
		_Color1("Color 1", Color) = (1,0.6004562,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Float0("Float 0", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Float2;
		uniform float2 _Vector0;
		uniform float _Float0;
		uniform float3 _Vector1;
		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _Float1;
		uniform float4 _Color2;
		uniform float _Float3;
		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 temp_cast_0 = (_Float2).xx;
			float2 uv_TexCoord5 = v.texcoord.xy * _Vector0;
			float2 panner11 = ( _Time.y * temp_cast_0 + uv_TexCoord5);
			float simplePerlin2D4 = snoise( panner11*_Float0 );
			simplePerlin2D4 = simplePerlin2D4*0.5 + 0.5;
			v.vertex.xyz += ( simplePerlin2D4 * _Vector1 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Float2).xx;
			float2 uv_TexCoord5 = i.uv_texcoord * _Vector0;
			float2 panner11 = ( _Time.y * temp_cast_0 + uv_TexCoord5);
			float simplePerlin2D4 = snoise( panner11*_Float0 );
			simplePerlin2D4 = simplePerlin2D4*0.5 + 0.5;
			o.Emission = ( _Color0 + ( _Color1 * step( simplePerlin2D4 , _Float1 ) ) + ( _Color2 * step( simplePerlin2D4 , _Float3 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;604;1368;395;997.7928;-61.62375;1;True;False
Node;AmplifyShaderEditor.Vector2Node;14;-2059.434,45.63868;Inherit;False;Property;_Vector0;Vector 0;9;0;Create;True;0;0;0;False;0;False;8,8;8,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;13;-1804.261,230.0513;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1783.847,151.1084;Inherit;False;Property;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1850.233,26.37551;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1661.505,319.4754;Inherit;False;Property;_Float0;Float 0;13;0;Create;True;0;0;0;False;0;False;0;0.3416948;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;11;-1551.918,27.19406;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1358.127,491.2685;Inherit;False;Property;_Float3;Float 3;7;0;Create;True;0;0;0;False;0;False;0;0.1205118;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;4;-1329.023,21.89845;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1362.438,250.988;Inherit;False;Property;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0;0.3044893;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-1044.908,26.78325;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-824.2415,132.336;Inherit;False;Property;_Color2;Color 2;12;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.8973289,0.5707547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-828.1068,-111.68;Inherit;False;Property;_Color1;Color 1;11;0;Create;True;0;0;0;False;0;False;1,0.6004562,0,0;1,0.7476941,0.1098039,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;19;-1040.596,267.0636;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;25;-332.4256,240.467;Inherit;False;Property;_Vector1;Vector 1;10;0;Create;True;0;0;0;False;0;False;0.3,1,0.3;0,0.45,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;27;-209.3062,152.8772;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-441.8866,-141.1425;Inherit;False;Property;_Color0;Color 0;5;0;Create;True;0;0;0;False;0;False;1,0.380561,0,0;1,0.5673151,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-577.5889,2.595569;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-567.4397,243.7018;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-182.376,-20.99954;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-144.1008,222.4819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;30.85077,-67.2322;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;lava shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;14;0
WireConnection;11;0;5;0
WireConnection;11;2;12;0
WireConnection;11;1;13;0
WireConnection;4;0;11;0
WireConnection;4;1;22;0
WireConnection;9;0;4;0
WireConnection;9;1;10;0
WireConnection;19;0;4;0
WireConnection;19;1;18;0
WireConnection;27;0;4;0
WireConnection;15;0;16;0
WireConnection;15;1;9;0
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;17;0;1;0
WireConnection;17;1;15;0
WireConnection;17;2;20;0
WireConnection;26;0;27;0
WireConnection;26;1;25;0
WireConnection;0;2;17;0
WireConnection;0;11;26;0
ASEEND*/
//CHKSM=FA1E461905ED2C2C0AAEFFB5B57E534585BAE82C