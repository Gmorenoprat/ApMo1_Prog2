using UnityEngine;

public class Apple : Collectable
{
    public Rigidbody rb;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public override void DarStats(Collider other)
    {
        other.gameObject.GetComponent<ICollector>().GetApple();
    }


}
