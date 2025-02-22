﻿using UnityEngine;

[ExecuteAlways]
public class DepthNormals : MonoBehaviour
{
    public Material material;

    private  void Start()
    {
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.DepthNormals;
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}