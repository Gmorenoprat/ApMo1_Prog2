// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HoneyCombShield"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_texmovement("tex movement", Vector) = (0,0.2,0,0)
		_texturescale("texture scale", Vector) = (0,0,0,0)
		_textureintensity("texture intensity", Float) = 0
		_masklevel("mask level", Range( 0 , 1)) = 0.7390757
		_Holohigh("Holo high", Range( 0 , 1)) = 0.7335475
		_Hologradient("Holo gradient", Range( -3 , 1)) = 0
		_fresnelint("fresnel int", Range( 0 , 3)) = 0
		_fresnelsacale("fresnel sacale", Float) = 0
		_Color0("Color 0", Color) = (0,0.772549,0.9804161,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			half ASEVFace : VFACE;
			float4 screenPos;
		};

		uniform float4 _Color0;
		uniform float _textureintensity;
		uniform sampler2D _TextureSample0;
		uniform float2 _texmovement;
		uniform float2 _texturescale;
		uniform float _masklevel;
		uniform float _Holohigh;
		uniform float _Hologradient;
		uniform float _fresnelint;
		uniform float _fresnelsacale;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord29 = i.uv_texcoord * _texturescale;
			float2 panner30 = ( 1.0 * _Time.y * _texmovement + uv_TexCoord29);
			float4 temp_output_38_0 = saturate( tex2D( _TextureSample0, panner30 ) );
			float4 lerpResult50 = lerp( temp_output_38_0 , ( 1.0 - temp_output_38_0 ) , _masklevel);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float smoothstepResult62 = smoothstep( _Holohigh , _Hologradient , ase_vertex3Pos.y);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV67 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode67 = ( 0.0 + _fresnelint * pow( 1.0 - fresnelNdotV67, _fresnelsacale ) );
			float switchResult102 = (((i.ASEVFace>0)?(fresnelNode67):(0.0)));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth41 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth41 = abs( ( screenDepth41 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.21 ) );
			float4 temp_output_86_0 = ( ( ( _textureintensity * lerpResult50 ) * smoothstepResult62 ) + switchResult102 + ( step( distanceDepth41 , 0.36 ) + ( 1.0 - saturate( distanceDepth41 ) ) ) );
			o.Emission = saturate( ( _Color0 * temp_output_86_0 ) ).rgb;
			o.Alpha = temp_output_86_0.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;446;1543;553;2891.936;-370.1355;1.502029;True;False
Node;AmplifyShaderEditor.CommentaryNode;100;-2803.105,58.44725;Inherit;False;1753.522;403.7986;Comment;11;26;28;29;30;35;38;42;50;43;99;98;texture movement;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;26;-2753.105,155.2375;Inherit;False;Property;_texturescale;texture scale;2;0;Create;True;0;0;0;False;0;False;0,0;6,6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2569.668,136.3289;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;28;-2532.521,261.0502;Inherit;False;Property;_texmovement;tex movement;1;0;Create;True;0;0;0;False;0;False;0,0.2;-0.2,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;30;-2312.368,136.3831;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;35;-2111.433,108.4473;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;9f68f5cda7b156d438ab21b15cc8b536;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;97;-2309.693,1345.823;Inherit;False;1090.142;418.9191;Comment;7;47;40;41;59;60;46;61;colision;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;38;-1806.621,114.2483;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2267.128,1460.017;Inherit;False;Constant;_Float0;Float 0;9;0;Create;True;0;0;0;False;0;False;0.21;0.21;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;-1968.033,895.1549;Inherit;False;748.5531;433.8561;Comment;4;62;57;56;54;semi esfera mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1762.035,345.3565;Inherit;False;Property;_masklevel;mask level;4;0;Create;True;0;0;0;False;0;False;0.7390757;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;43;-1622,116.0133;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;41;-2103.905,1441.252;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;103;-2217.424,548.137;Inherit;False;997.4019;309.4417;fresnel;4;69;68;67;102;fresnel;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;54;-1740.453,952.0139;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-1914.562,741.5787;Inherit;False;Property;_fresnelsacale;fresnel sacale;8;0;Create;True;0;0;0;False;0;False;0;3.98;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2014.216,664.5868;Inherit;False;Property;_fresnelint;fresnel int;7;0;Create;True;0;0;0;False;0;False;0;1.84;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1839.526,1402.16;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;0.36;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;50;-1407.665,303.2459;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1830.587,1220.616;Inherit;False;Property;_Hologradient;Holo gradient;6;0;Create;True;0;0;0;False;0;False;0;-0.07;-3;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-1426.909,123.8671;Inherit;False;Property;_textureintensity;texture intensity;3;0;Create;True;0;0;0;False;0;False;0;2.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;47;-1823.47,1550.796;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1831.511,1117.86;Inherit;False;Property;_Holohigh;Holo high;5;0;Create;True;0;0;0;False;0;False;0.7335475;0.391;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;67;-1718.233,598.1534;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;62;-1489.28,1001.388;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;59;-1641.378,1551.263;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-1211.583,281.3145;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;60;-1618.057,1442.13;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;102;-1416.334,598.8334;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-1479.577,1479.627;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-983.4218,487.7;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;91;-789.9583,337.3322;Inherit;False;Property;_Color0;Color 0;9;0;Create;True;0;0;0;False;0;False;0,0.772549,0.9804161,0;0,0.7215686,0.9804161,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-790.5147,575.7541;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-503.3959,341.3542;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;94;-277.8201,341.5919;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-90.78621,385.8825;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;HoneyCombShield;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;26;0
WireConnection;30;0;29;0
WireConnection;30;2;28;0
WireConnection;35;1;30;0
WireConnection;38;0;35;0
WireConnection;43;0;38;0
WireConnection;41;0;40;0
WireConnection;50;0;38;0
WireConnection;50;1;43;0
WireConnection;50;2;42;0
WireConnection;47;0;41;0
WireConnection;67;2;69;0
WireConnection;67;3;68;0
WireConnection;62;0;54;2
WireConnection;62;1;57;0
WireConnection;62;2;56;0
WireConnection;59;0;47;0
WireConnection;98;0;99;0
WireConnection;98;1;50;0
WireConnection;60;0;41;0
WireConnection;60;1;46;0
WireConnection;102;0;67;0
WireConnection;61;0;60;0
WireConnection;61;1;59;0
WireConnection;89;0;98;0
WireConnection;89;1;62;0
WireConnection;86;0;89;0
WireConnection;86;1;102;0
WireConnection;86;2;61;0
WireConnection;90;0;91;0
WireConnection;90;1;86;0
WireConnection;94;0;90;0
WireConnection;0;2;94;0
WireConnection;0;9;86;0
ASEEND*/
//CHKSM=410EF07D6CEC73A54BD9761B57E204E04D9FF024