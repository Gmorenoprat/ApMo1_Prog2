// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "lava shader"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Float2("Float 0", Float) = 0.2
		_TextureSample1("Texture Sample 0", 2D) = "white" {}
		_Color0("Color 0", Color) = (1,0.380561,0,0)
		_Float5("Float 2", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Float4("Float 3", Float) = 0
		_Float3("Float 3", Range( 0 , 1)) = 0
		_Vector1("Vector 1", Vector) = (0.3,1,0.3,0)
		_Color1("Color 1", Color) = (1,0.6004562,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Float0("Float 0", Range( 0 , 1)) = 0
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
			float3 worldPos;
		};

		uniform float _Float2;
		uniform sampler2D _TextureSample1;
		uniform float _Float4;
		uniform float _Float5;
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
			float4 appendResult37 = (float4(_Float2 , _Float2 , 0.0 , 0.0));
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 temp_output_30_0 = (ase_worldPos).xz;
			float4 lerpResult36 = lerp( float4( temp_output_30_0, 0.0 , 0.0 ) , tex2Dlod( _TextureSample1, float4( ( temp_output_30_0 / _Float4 ), 0, 0.0) ) , _Float5);
			float2 panner11 = ( _Time.y * appendResult37.xy + lerpResult36.rg);
			float simplePerlin2D4 = snoise( panner11*_Float0 );
			simplePerlin2D4 = simplePerlin2D4*0.5 + 0.5;
			v.vertex.xyz += ( simplePerlin2D4 * _Vector1 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult37 = (float4(_Float2 , _Float2 , 0.0 , 0.0));
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_30_0 = (ase_worldPos).xz;
			float4 lerpResult36 = lerp( float4( temp_output_30_0, 0.0 , 0.0 ) , tex2D( _TextureSample1, ( temp_output_30_0 / _Float4 ) ) , _Float5);
			float2 panner11 = ( _Time.y * appendResult37.xy + lerpResult36.rg);
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
0;728;1511;273;2585.646;131.345;1.020773;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;28;-2974.968,-47.22918;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;30;-2781.253,-52.37621;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2724.216,91.80464;Inherit;False;Property;_Float4;Float 3;10;0;Create;True;0;0;0;False;0;False;0;5.89;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-2533.091,75.03795;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;33;-2141.952,-14.58642;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1920.179,-82.89838;Inherit;False;Property;_Float2;Float 0;5;0;Create;True;0;0;0;False;0;False;0.2;0.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2366.373,252.0794;Inherit;False;Property;_Float5;Float 2;8;0;Create;True;0;0;0;False;0;False;0;0.5529163;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-2389.196,47.20348;Inherit;True;Property;_TextureSample1;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;None;84b6903c809f8bb4b971da6a0e8c6800;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;38;-1763.73,100.119;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;36;-2047.006,27.76743;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1737.406,-78.71076;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1661.505,319.4754;Inherit;False;Property;_Float0;Float 0;15;0;Create;True;0;0;0;False;0;False;0;0.3416948;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;11;-1551.918,27.19406;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;4;-1329.023,21.89845;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1362.438,250.988;Inherit;False;Property;_Float1;Float 1;9;0;Create;True;0;0;0;False;0;False;0;0.3044893;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1358.127,491.2685;Inherit;False;Property;_Float3;Float 3;11;0;Create;True;0;0;0;False;0;False;0;0.1205118;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-1044.908,26.78325;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-824.2415,132.336;Inherit;False;Property;_Color2;Color 2;14;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.8973289,0.5707547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;19;-1040.596,267.0636;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-828.1068,-111.68;Inherit;False;Property;_Color1;Color 1;13;0;Create;True;0;0;0;False;0;False;1,0.6004562,0,0;1,0.7476941,0.1098039,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-567.4397,243.7018;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-441.8866,-141.1425;Inherit;False;Property;_Color0;Color 0;7;0;Create;True;0;0;0;False;0;False;1,0.380561,0,0;1,0.5673151,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;25;-332.4256,240.467;Inherit;False;Property;_Vector1;Vector 1;12;0;Create;True;0;0;0;False;0;False;0.3,1,0.3;0,0.45,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-577.5889,2.595569;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;27;-209.3062,152.8772;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-144.1008,222.4819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-182.376,-20.99954;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;30.85077,-67.2322;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;lava shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;28;0
WireConnection;31;0;30;0
WireConnection;31;1;29;0
WireConnection;33;0;30;0
WireConnection;34;1;31;0
WireConnection;36;0;33;0
WireConnection;36;1;34;0
WireConnection;36;2;35;0
WireConnection;37;0;32;0
WireConnection;37;1;32;0
WireConnection;11;0;36;0
WireConnection;11;2;37;0
WireConnection;11;1;38;0
WireConnection;4;0;11;0
WireConnection;4;1;22;0
WireConnection;9;0;4;0
WireConnection;9;1;10;0
WireConnection;19;0;4;0
WireConnection;19;1;18;0
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;15;0;16;0
WireConnection;15;1;9;0
WireConnection;27;0;4;0
WireConnection;26;0;27;0
WireConnection;26;1;25;0
WireConnection;17;0;1;0
WireConnection;17;1;15;0
WireConnection;17;2;20;0
WireConnection;0;2;17;0
WireConnection;0;11;26;0
ASEEND*/
//CHKSM=70C51282BCDC0A115F290AE6BD1C24894261948A