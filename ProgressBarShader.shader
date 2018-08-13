Shader "Progress"
{
    Properties
    {
        _Value ("Value", Range (0, 1)) = 0.5
        _ColorEmpty ("ColorEmpty", Color) = (0.01, 0.6, 0.1, 1)
        _ColorFilled ("ColorFilled", Color) = (0.2, 1, 0.2, 1)
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent" 
        }

        Pass
        {
            AlphaToMask On

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            float _Value;
            float4 _ColorEmpty;
            float4 _ColorFilled;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                if (i.uv.r > _Value) {
                    return _ColorEmpty;
                }
                return _ColorFilled;
            }
            ENDCG
        }
    }
}
