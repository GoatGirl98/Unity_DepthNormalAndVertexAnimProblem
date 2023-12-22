Shader "Hidden/DetphTexture"
{
    Properties
    {
        [HideInInspector] _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
		Tags {"Queue" = "Transparent" "RenderType" = "Transparent"  "IgnoreProjector" = "True"}

		Lighting On        
        //Cull   Off
        //ZWrite Off
        //ZTest  Always

        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex   vert_img
            #pragma fragment frag

            sampler2D _MainTex;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f 
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            v2f vert_img (appdata v)
            {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;    
                return o;        
            }

            // float4 frag(v2f_img input) : SV_Target
            float4 frag(v2f input) : SV_Target
            {
                const float bias = 5;
                // origin solution
                // return tex2D(_MainTex, input.uv) * bias;
                // original depth shader in 2019.4.18 is invalid in 2022.3.15
                /*
                float uv = UNITY_PROJ_COORD(input.pos);
                float depthValue = tex2D(_MainTex, float2(input.pos.x, input.pos.y)).r;
#if defined(UNITY_REVERSED_Z)
				depthValue = 1.0 - depthValue;
#endif          
                return float4(depthValue, depthValue, depthValue, 1.0f);
                */
                float depthValue = (tex2D(_MainTex, float2(input.uv))).r;
                // float depthValue = tex2Dproj(_MainTex, input.pos).r;
#if defined(UNITY_REVERSED_Z)
				depthValue = 1.0 - depthValue;
#endif
                return float4(depthValue, depthValue, depthValue, 1.0f);


            }

            ENDCG
        }
    }
}
