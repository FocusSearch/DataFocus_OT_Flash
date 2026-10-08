# DataFocus OT Flash · r53

**面向 Agent 的结构化与非结构化融合知识后台**

OT Flash 将 Doris 中的业务数据、文档知识和本体语义连接起来，为 Agent 提供数据查询、知识检索和来源追溯能力。保留原 BI 工作台、权限和业务流程，聚焦知识服务；此发行线不包含完整 ETL 产品能力与 AutoML。

## 本次更新

- 吸收 mac 非 AutoML 本体增量，包括维护批量读取、发布闭包复用和精确修订检查优化。
- 补齐 Doris 中文字段、Decimal 类型、真实 JDBC 执行证据与查询 ID 兼容。
- 修补文档批量上传、声明、整文件校验与封存，绑定实际 DocWorker 源码。
- 更新 Agent Runtime 和 MCP 候选/预览合同适配。

## 下载

**平台：CentOS 7 x86_64 · 版本：0.1.0-test / r53 · Pre-release**

完整归档 **7,191,482,492 字节（约 6.70 GiB）**，按四个分卷提供。下载 Assets 中的 **`download-r53.sh`**，然后执行：

```bash
bash download-r53.sh
```

脚本直连下载、断点续传、逐卷校验、自动合并并校验完整包。预留至少 15 GiB 下载空间。也可以手动下载 `.part-01` 至 `.part-04` 四个文件，按顺序合并；**不要逐卷解压**。下方的 **Source code** 仅为本仓库发行资料，不能用于安装产品。

```text
OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz
SHA-256: e045423b2744e0f28c3f46b649aa20724ea8d79686d5d96e8ed7c48b4e699abd
```

## 验收范围

已通过原完整安装器升级、2,145 个安装文件核对、356 个成功迁移、登录和 Doris 原读表；完成 2,505 行结构化来源验证、两份文档获取到索引的全流程，以及本体候选创建、预览和草稿续改。

**正式本体发布尚未完成本包验收**：测试实例缺少原校验预算账户，发布公钥信任也需管理员预先配置。发布后查询、分页、融合引用、冲突处理和局部更新未宣称通过；也未逐一验收所有数据库、文档格式和语言。新实例需要独立授权与模型配置。

## 资料

- [产品介绍](https://github.com/FocusSearch/DataFocus_OT_Flash#readme)
- [下载与合并](https://github.com/FocusSearch/DataFocus_OT_Flash/blob/main/docs/DOWNLOAD.md)
- [安装指南](https://github.com/FocusSearch/DataFocus_OT_Flash/blob/main/docs/INSTALL.md)
- [完整更新、验收与已知限制](https://github.com/FocusSearch/DataFocus_OT_Flash/blob/main/docs/RELEASE-r53.md)

初始管理员 `admin`，初始密码 `2020@Datafocus`；完成原账户初始化与改密流程。产品授权及第三方组件许可证以随包资料为准。
