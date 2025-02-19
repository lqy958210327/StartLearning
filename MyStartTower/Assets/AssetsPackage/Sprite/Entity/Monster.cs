using UnityEngine;

public class Monster : GameObjectBase
{
    public int Health { get; private set; }
    public float Speed { get; set; }

    public Monster(int health, float speed)
    {
        Health = health;
        Speed = speed;
    }

    // Unity生命周期方法，重写以处理怪物逻辑
    private void Update()
    {
        // 怪物移动、攻击等逻辑
        OnUpdate(); // 调用虚拟方法（虽然这里没有重写，但子类可能会重写）
    }

    // 当怪物受到伤害时调用
    public void TakeDamage(int damage)
    {
        Health -= damage;
        if (Health <= 0)
        {
            Die();
        }
    }

    // 怪物死亡逻辑
    private void Die()
    {
        // 播放死亡动画、销毁对象、增加分数等
        Destroy(gameObject);
    }

    // 可以重写OnCollision来处理怪物与其他对象的碰撞
    // 但通常我们会使用OnTriggerEnter2D或OnCollisionEnter2D
}