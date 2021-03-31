Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7C3454E0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Mar 2021 02:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCWBT3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Mar 2021 21:19:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCWBTX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Mar 2021 21:19:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4D3l5mJMznVRG;
        Tue, 23 Mar 2021 09:16:51 +0800 (CST)
Received: from [10.174.177.87] (10.174.177.87) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 09:19:15 +0800
Subject: Re: [PATCH V2] scsi: iscsi_tcp: Fix use-after-free when do
 get_host_param
To:     <open-iscsi@googlegroups.com>, <michael.christie@oracle.com>,
        <lduncan@suse.com>, <cleech@redhat.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <michaelc@cs.wisc.edu>,
        <James.Bottomley@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>, <haowenchao@huawei.com>
References: <1616309229-612596-1-git-send-email-wubo40@huawei.com>
 <2fb1bffa-0717-f3b0-cdd6-2960a898b496@oracle.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <ee03422c-85fe-5ecc-cd14-8c11a6ac2569@huawei.com>
Date:   Tue, 23 Mar 2021 09:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <2fb1bffa-0717-f3b0-cdd6-2960a898b496@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021/3/22 4:21, michael.christie@oracle.com wrote:
> On 3/21/21 1:47 AM, Wu Bo wrote:
>> From: Wu Bo <wubo40@huawei.com>
>>
>> iscsid(cpu1): Logout of iscsi session, will do destroy session,
>> tcp_sw_host->session is not set to NULL before release the iscsi session.
>> in the iscsi_sw_tcp_session_destroy().
>>
>> iscsadm(cpu2): Get host parameters access to tcp_sw_host->session in the
>> iscsi_sw_tcp_host_get_param(), tcp_sw_host->session is not NULL,
>> but pointed to a freed space.
>>
>> Add ihost->lock and kref to protect the session,
>> between get host parameters and destroy iscsi session.
>>
>> [29844.848044] sd 2:0:0:1: [sdj] Synchronizing SCSI cache
>> [29844.923745] scsi 2:0:0:1: alua: Detached
>> [29844.927840] ==================================================================
>> [29844.927861] BUG: KASAN: use-after-free in iscsi_sw_tcp_host_get_param+0xf4/0x218 [iscsi_tcp]
>> [29844.927864] Read of size 8 at addr ffff80002c0b8f68 by task iscsiadm/523945
>> [29844.927871] CPU: 1 PID: 523945 Comm: iscsiadm Kdump: loaded Not tainted 4.19.90.kasan.aarch64
>> [29844.927873] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [29844.927875] Call trace:
>> [29844.927884]  dump_backtrace+0x0/0x270
>> [29844.927886]  show_stack+0x24/0x30
>> [29844.927895]  dump_stack+0xc4/0x120
>> [29844.927902]  print_address_description+0x68/0x278
>> [29844.927904]  kasan_report+0x20c/0x338
>> [29844.927906]  __asan_load8+0x88/0xb0
>> [29844.927910]  iscsi_sw_tcp_host_get_param+0xf4/0x218 [iscsi_tcp]
>> [29844.927932]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0x84/0xa0 [scsi_transport_iscsi]
>> [29844.927938]  dev_attr_show+0x48/0x90
>> [29844.927943]  sysfs_kf_seq_show+0x100/0x1e0
>> [29844.927946]  kernfs_seq_show+0x88/0xa0
>> [29844.927949]  seq_read+0x164/0x748
>> [29844.927951]  kernfs_fop_read+0x204/0x308
>> [29844.927956]  __vfs_read+0xd4/0x2d8
>> [29844.927958]  vfs_read+0xa8/0x198
>> [29844.927960]  ksys_read+0xd0/0x180
>> [29844.927962]  __arm64_sys_read+0x4c/0x60
>> [29844.927966]  el0_svc_common+0xa8/0x230
>> [29844.927969]  el0_svc_handler+0xdc/0x138
>> [29844.927971]  el0_svc+0x10/0x218
>>
>> [29844.928063] Freed by task 53358:
>> [29844.928066]  __kasan_slab_free+0x120/0x228
>> [29844.928068]  kasan_slab_free+0x10/0x18
>> [29844.928069]  kfree+0x98/0x278
>> [29844.928083]  iscsi_session_release+0x84/0xa0 [scsi_transport_iscsi]
>> [29844.928085]  device_release+0x4c/0x100
>> [29844.928089]  kobject_put+0xc4/0x288
>> [29844.928091]  put_device+0x24/0x30
>> [29844.928105]  iscsi_free_session+0x60/0x70 [scsi_transport_iscsi]
>> [29844.928112]  iscsi_session_teardown+0x134/0x158 [libiscsi]
>> [29844.928116]  iscsi_sw_tcp_session_destroy+0x7c/0xd8 [iscsi_tcp]
>> [29844.928129]  iscsi_if_rx+0x1538/0x1f00 [scsi_transport_iscsi]
>> [29844.928131]  netlink_unicast+0x338/0x3c8
>> [29844.928133]  netlink_sendmsg+0x51c/0x588
>> [29844.928135]  sock_sendmsg+0x74/0x98
>> [29844.928137]  ___sys_sendmsg+0x434/0x470
>> [29844.928139]  __sys_sendmsg+0xd4/0x148
>> [29844.928141]  __arm64_sys_sendmsg+0x50/0x60
>> [29844.928143]  el0_svc_common+0xa8/0x230
>> [29844.928146]  el0_svc_handler+0xdc/0x138
>> [29844.928147]  el0_svc+0x10/0x218
>> [29844.928148]
>> [29844.928150] The buggy address belongs to the object at ffff80002c0b8880#012 which belongs to the cache kmalloc-2048 of size 2048
>> [29844.928153] The buggy address is located 1768 bytes inside of#012 2048-byte region [ffff80002c0b8880, ffff80002c0b9080)
>> [29844.928154] The buggy address belongs to the page:
>> [29844.928158] page:ffff7e0000b02e00 count:1 mapcount:0 mapping:ffff8000d8402600 index:0x0 compound_mapcount: 0
>> [29844.928902] flags: 0x7fffe0000008100(slab|head)
>> [29844.929215] raw: 07fffe0000008100 ffff7e0003535e08 ffff7e00024a9408 ffff8000d8402600
>> [29844.929217] raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
>> [29844.929219] page dumped because: kasan: bad access detected
>> [29844.929219]
>> [29844.929221] Memory state around the buggy address:
>> [29844.929223]  ffff80002c0b8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [29844.929225]  ffff80002c0b8e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [29844.929227] >ffff80002c0b8f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [29844.929228]                                                           ^
>> [29844.929230]  ffff80002c0b8f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [29844.929232]  ffff80002c0b9000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [29844.929232] ==================================================================
>> [29844.929234] Disabling lock debugging due to kernel taint
>> [29844.969534] scsi host2: iSCSI Initiator over TCP/IP
>>
>> Fixes: a79af8a64d39 ("[SCSI] iscsi_tcp: use iscsi_conn_get_addr_param libiscsi function")
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> Signed-off-by: WenChao Hao <haowenchao@huawei.com>
>> ---
>>   drivers/scsi/iscsi_tcp.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
>> index 93ce990..579aa80 100644
>> --- a/drivers/scsi/iscsi_tcp.c
>> +++ b/drivers/scsi/iscsi_tcp.c
>> @@ -783,22 +783,32 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
>>   				       enum iscsi_host_param param, char *buf)
>>   {
>>   	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(shost);
>> -	struct iscsi_session *session = tcp_sw_host->session;
>> +	struct iscsi_session *session;
>> +	struct iscsi_host *ihost = shost_priv(shost);
>>   	struct iscsi_conn *conn;
>>   	struct iscsi_tcp_conn *tcp_conn;
>>   	struct iscsi_sw_tcp_conn *tcp_sw_conn;
>>   	struct sockaddr_in6 addr;
>> +	unsigned long flags;
>>   	int rc;
>>   
>>   	switch (param) {
>>   	case ISCSI_HOST_PARAM_IPADDRESS:
>> -		if (!session)
>> +		spin_lock_irqsave(&ihost->lock, flags);
>> +		session = tcp_sw_host->session;
>> +		if (!session) {
>> +			spin_unlock_irqrestore(&ihost->lock, flags);
>>   			return -ENOTCONN;
>> +		}
>> +
>> +		get_device(&(session->cls_session->dev));
>> +		spin_unlock_irqrestore(&ihost->lock, flags);
>>   
>>   		spin_lock_bh(&session->frwd_lock);
>>   		conn = session->leadconn;
>>   		if (!conn) {
>>   			spin_unlock_bh(&session->frwd_lock);
>> +			put_device(&(session->cls_session->dev));
>>   			return -ENOTCONN;
>>   		}
>>   		tcp_conn = conn->dd_data;
>> @@ -806,12 +816,14 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
>>   		tcp_sw_conn = tcp_conn->dd_data;
>>   		if (!tcp_sw_conn->sock) {
>>   			spin_unlock_bh(&session->frwd_lock);
>> +			put_device(&(session->cls_session->dev));
>>   			return -ENOTCONN;
>>   		}
>>   
>>   		rc = kernel_getsockname(tcp_sw_conn->sock,
>>   					(struct sockaddr *)&addr);
>>   		spin_unlock_bh(&session->frwd_lock);
>> +		put_device(&(session->cls_session->dev));
>>   		if (rc < 0)
>>   			return rc;
>>   
>> @@ -901,10 +913,17 @@ static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
>>   {
>>   	struct Scsi_Host *shost = iscsi_session_to_shost(cls_session);
>>   	struct iscsi_session *session = cls_session->dd_data;
>> +	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(shost);
>> +	struct iscsi_host *ihost = shost_priv(shost);
>> +	unsigned long flags;
>>   
>>   	if (WARN_ON_ONCE(session->leadconn))
>>   		return;
>>   
>> +	spin_lock_irqsave(&ihost->lock, flags);
>> +	tcp_sw_host->session = NULL;
>> +	spin_unlock_irqrestore(&ihost->lock, flags);
>> +
>>   	iscsi_tcp_r2tpool_free(cls_session->dd_data);
>>   	iscsi_session_teardown(cls_session);
>>   
> 
> We are tearing down the structs in the wrong order. I think sysfs removal
> functions will wait for users accessing the object, so we can do:
> 
> 1. remove session from sysfs (iscsi_remove_session)
> 2. remove host from syfs (iscsi_host_remove)
> 
> At this point we userspace is not accessing the host and session structs so
> we can start to tear them down.
> 
> 3. free session: iscsi_tcp_r2tpool_free, a modified iscsi_session_teardown
> that only does iscsi_free_session instead of iscsi_destroy_session.
> 4. free host (iscsi_host_free).
> 
> Before the device_del function waited for userspace to release refcounts
> for sysfs accesses we could have also moved some of thise to a release function.
> 

Hi,

Thank you for your suggestion, I will try to modify tearing down the 
structs order and send the V3 version after testing.

Thanks.


