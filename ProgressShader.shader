Shader "Unlit/ProgressShader"
{
	Properties
	{
        _Value ("Value", Range(0,1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

            float _Value;
            
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                float value = _Value * 360.0;
                float angle = atan2(i.uv.r - 0.5, i.uv.g - 0.5);
                angle = degrees(angle);

                if (angle < 0) {
                    angle = angle + 360;
                }

                if (angle > value) {
                    return float4(0.5,0.5,0.5,1);
                } else{
                    return float4(0,1,0,1);
                }
            }
			ENDCG
		}
	}
}
