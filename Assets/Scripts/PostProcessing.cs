using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostProcessing : MonoBehaviour {
	
	public Material mat;
	public Texture2D noiseTex;

	void Start() {
		mat.SetTexture("_NoiseTex", noiseTex);
	}

	void FixedUpdate() {
		mat.SetFloat("_NoiseOffset", Time.time * 0.05f);
	}

    void OnRenderImage(RenderTexture src, RenderTexture dst) {
		Graphics.Blit(src, dst, mat);
	}
}

