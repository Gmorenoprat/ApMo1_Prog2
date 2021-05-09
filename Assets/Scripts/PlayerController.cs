using UnityEngine;

public class PlayerController
{
    Movement _movement;
    BattleMechanics _battle;

    public PlayerController(Movement m, BattleMechanics b)
    {
        _movement = m;
        _battle = b;
    }

    public void OnUpdate()
    {
        if (Input.GetKeyDown(KeyCode.Space))
            _movement.Jump();

        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");

        if (v != 0 || h != 0)
            _movement.Move(v, h);

        if (Input.GetKeyDown(KeyCode.G))
        {
            _battle.Attack();
        }
    }
}