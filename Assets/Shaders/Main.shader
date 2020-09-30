Shader "Custom/Main" {
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
		_NoiseTex ("Noise Tex", 2D) = "white" {}
		// _NoiseOffset ("Noise Offset", Float) = 0
    }
    SubShader {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
			sampler2D _NoiseTex;
			float _NoiseOffset;

            fixed4 frag (v2f i) : SV_Target {
				fixed2 noiseOffset = fixed2(0, _NoiseOffset);
				fixed2 mainOffset = tex2D(_NoiseTex, i.uv + noiseOffset).rg * 0.035;
                fixed4 col = tex2D(_MainTex, i.uv + mainOffset);
                // just invert the colors
                // col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}

