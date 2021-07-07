using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class checkpointText : MonoBehaviour
{
    public float cont;

    // Start is called before the first frame update
    void Awake()
    {
        cont = 1.7f;
    }

    // Update is called once per frame
    void Update()
    {
        if(cont >= 0)
        {
            this.gameObject.SetActive(true);
            cont -= Time.deltaTime;
        }
        else
        {
            this.gameObject.SetActive(false);
            cont = 1.7f;
        }
    }
}
