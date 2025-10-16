using UnityEngine;

public class TowerBase : MonoBehaviour
{
    // 塔的属性，比如攻击范围、攻击速度、子弹类型等
    public float AttackRange { get; private set; }
    public float FireRate { get; private set; }
    public GameObject BulletPrefab { get; private set; }
    private float lastFireTime;
    // ... 其他塔的属性

    public TowerBase()
    {
        // 注意：在Unity中，你不应该这样定义构造函数！
        // 这只是为了说明如何初始化属性。在Unity中，你应该在Start或Awake中做这些。
        // AttackRange = attackRange;
        // FireRate = fireRate;
        // BulletPrefab = bulletPrefab;
    }

    protected virtual void Awake()
    {
        // 可以在这里进行任何必要的初始化
    }

    protected virtual void Start()
    {
        // 初始化攻击范围和射速
        // 这些值也可以直接在Unity编辑器中设置
        AttackRange = 10f; // 示例值
        FireRate = 1f; // 示例值，每秒射击次数
        lastFireTime = -FireRate; // 确保第一帧可以射击

        // 初始化攻击范围和射速（这些值也可以在Unity编辑器中直接设置）
        // ... 可能还有其他初始化代码 ...
    }

    protected virtual void Update()
    {
        if (Time.time - lastFireTime >= 1f / FireRate)
        {
            // 射击逻辑，这里假设有一个目标位置targetPosition
            // 在实际游戏中，你需要获取或指定一个目标
            Vector3 targetPosition = new Vector3(0f, 0f, 0f); //GetTargetPosition(); // 这是一个假设的方法，你需要实现它
            Attack(targetPosition);
            lastFireTime = Time.time;
        }
    }

    //实例化子弹
    protected virtual void Attack(Vector3 targetPosition)
    {
        GameObject bullet = Instantiate(BulletPrefab, transform.position, Quaternion.LookRotation(targetPosition - transform.position));
        Bullet bulletScript = bullet.GetComponent<Bullet>();
        if (bulletScript != null)
        {
            bulletScript.targetPosition = targetPosition;
            ApplySpecialEffects(bulletScript);
        }
    }
 
    protected virtual void ApplySpecialEffects(Bullet bulletScript)
    {
        // 默认情况下不应用任何特殊效果
        // 根据塔的类型设置子弹的特殊效果
            if (this is IceTower)
            {
                bulletScript.hasSlowEffect = true;
                bulletScript.slowAmount = ((IceTower)this).slowAmount;
            }
            else if (this is PoisonTower)
            {
                bulletScript.hasPoisonEffect = true;
                bulletScript.poisonDamagePerSecond = ((PoisonTower)this).poisonDamagePerSecond;
                // 注意：这里没有直接设置duration，因为需要在Enemy中处理定时清除
            }
            // 可以为其他类型的塔添加更多的条件逻辑
    }

    // 可以重写OnCollision，但通常塔不会直接与其他对象碰撞，而是发射子弹
}