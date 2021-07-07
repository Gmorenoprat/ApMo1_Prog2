// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "magic portal"
{
	Properties
	{
		_Float1("Float 1", Float) = 0
		_Float2("Float 2", Range( 0 , 1)) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_Holohigh1("Holo high", Range( 0 , 1)) = 0.7335475
		_Hologradient1("Holo gradient", Range( -3 , 1)) = 0
		_Float0("Float 0", Range( 0 , 0.5)) = 0
		_fresnelint1("fresnel int", Range( 0 , 3)) = 0.2310425
		_Float3("Float 3", Float) = 2.85
		_fresnelsacale1("fresnel sacale", Float) = 3.53
		_Float5("Float 5", Float) = 0.42
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			half ASEVFace : VFACE;
			float4 screenPos;
		};

		uniform float4 _Color0;
		uniform float _Float1;
		uniform float2 _Vector0;
		uniform float _Float2;
		uniform float _Holohigh1;
		uniform float _Hologradient1;
		uniform float _fresnelint1;
		uniform float _fresnelsacale1;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Float3;
		uniform float _Float5;
		uniform float _Float0;


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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Float1).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * _Vector0;
			float2 panner6 = ( _Time.y * temp_cast_0 + uv_TexCoord2);
			float simplePerlin2D1 = snoise( panner6 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float smoothstepResult24 = smoothstep( _Holohigh1 , _Hologradient1 , ase_vertex3Pos.y);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV38 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode38 = ( 0.0 + _fresnelint1 * pow( 1.0 - fresnelNdotV38, _fresnelsacale1 ) );
			float switchResult39 = (((i.ASEVFace>0)?(fresnelNode38):(0.0)));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth29 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth29 = abs( ( screenDepth29 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Float3 ) );
			float temp_output_11_0 = saturate( ( ( step( simplePerlin2D1 , _Float2 ) * smoothstepResult24 ) + ( smoothstepResult24 * switchResult39 ) + ( step( distanceDepth29 , _Float5 ) + ( 1.0 - saturate( distanceDepth29 ) ) ) ) );
			float4 temp_output_12_0 = ( _Color0 * temp_output_11_0 );
			o.Albedo = temp_output_12_0.rgb;
			o.Emission = temp_output_12_0.rgb;
			o.Alpha = ( temp_output_11_0 * _Float0 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				float3 worldNormal : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;682;1529;319;3785.641;251.7754;3.80027;True;False
Node;AmplifyShaderEditor.Vector2Node;19;-1625.174,-124.4565;Inherit;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;0;False;0;False;0,0;3.06,30.31;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;8;-1325.216,-7.590185;Inherit;False;Property;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0;2.64;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1425.314,971.7451;Inherit;False;Property;_Float3;Float 3;9;0;Create;True;0;0;0;False;0;False;2.85;1.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1340.365,-144.699;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;7;-1325.888,80.10794;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;6;-1093.465,-52.49397;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1326.235,719.1552;Inherit;False;Property;_fresnelint1;fresnel int;8;0;Create;True;0;0;0;False;0;False;0.2310425;1.345882;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1226.581,796.1472;Inherit;False;Property;_fresnelsacale1;fresnel sacale;10;0;Create;True;0;0;0;False;0;False;3.53;4.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;29;-1242.847,954.7295;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-936.3567,164.6779;Inherit;False;Property;_Float2;Float 2;2;0;Create;True;0;0;0;False;0;False;0;0.3812734;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-962.726,430.1723;Inherit;False;Property;_Holohigh1;Holo high;5;0;Create;True;0;0;0;False;0;False;0.7335475;0.8027647;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-961.8019,532.9287;Inherit;False;Property;_Hologradient1;Holo gradient;6;0;Create;True;0;0;0;False;0;False;0;0.5888236;-3;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;21;-872.6678,269.326;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;38;-1030.252,652.7219;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;31;-962.412,1064.274;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-978.4678,915.6376;Inherit;False;Property;_Float5;Float 5;11;0;Create;True;0;0;0;False;0;False;0.42;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-893.8704,-58.03498;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-780.3203,1064.74;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-607.575,-56.37082;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;33;-756.9993,955.6075;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;24;-620.4945,313.7001;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;39;-728.3527,653.4019;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-347.5595,529.5541;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-342.6019,117.1834;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-618.5193,993.1045;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-87.30957,405.0388;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;11;-91.54691,115.7993;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-153.3015,-60.10199;Inherit;False;Property;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,1,0.9709253,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-114.3969,246.3349;Inherit;False;Property;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;0;0.4647059;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;104.7,-54.46164;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;168.6031,186.3349;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;439.2778,-52.37492;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;magic portal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;19;0
WireConnection;6;0;2;0
WireConnection;6;2;8;0
WireConnection;6;1;7;0
WireConnection;29;0;28;0
WireConnection;38;2;37;0
WireConnection;38;3;36;0
WireConnection;31;0;29;0
WireConnection;1;0;6;0
WireConnection;32;0;31;0
WireConnection;9;0;1;0
WireConnection;9;1;10;0
WireConnection;33;0;29;0
WireConnection;33;1;30;0
WireConnection;24;0;21;2
WireConnection;24;1;23;0
WireConnection;24;2;22;0
WireConnection;39;0;38;0
WireConnection;40;0;24;0
WireConnection;40;1;39;0
WireConnection;25;0;9;0
WireConnection;25;1;24;0
WireConnection;34;0;33;0
WireConnection;34;1;32;0
WireConnection;35;0;25;0
WireConnection;35;1;40;0
WireConnection;35;2;34;0
WireConnection;11;0;35;0
WireConnection;12;0;13;0
WireConnection;12;1;11;0
WireConnection;26;0;11;0
WireConnection;26;1;27;0
WireConnection;0;0;12;0
WireConnection;0;2;12;0
WireConnection;0;9;26;0
ASEEND*/
//CHKSM=B6532F3D13177AACE737EEF3F1AC79562EB87981