$ vim $jenkins/config.xml
修改<userSecurity>true</userSecurity>  true为false

```
<useSecurity>true</useSecurity>
  <authorizationStrategy class="com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy">
    <roleMap type="projectRoles">
      <role name="dc-chain" pattern="dc-chain.*">
```
