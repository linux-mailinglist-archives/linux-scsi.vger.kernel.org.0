Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8732C7ED
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355725AbhCDAdK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Mar 2021 19:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241117AbhCCPS2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Mar 2021 10:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614784600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdwTtmgVoGgNcz8nBwLl1FfQ9hlaGjTwxN2l/vfPQCQ=;
        b=LQrDATnyfkvVNR9iQ0qWHswi+oi0AyeMxpvrVVXfpKpVKl/iC/UkrNbqx754XaCK6PuwGr
        PwwwX93MlMhYRqLx6hZ3gMHAKKxO5Pz/TSeFjUTe7GT300afbdQvG6yWAdaHJN3X8pKc/Y
        5WG5iaNFVAq0gzY5rYBqiyynxxWUCqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-sMy3pAWSO_2HpKwpUbPVxA-1; Wed, 03 Mar 2021 10:16:38 -0500
X-MC-Unique: sMy3pAWSO_2HpKwpUbPVxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08A161007281;
        Wed,  3 Mar 2021 15:16:37 +0000 (UTC)
Received: from T590 (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 526735C241;
        Wed,  3 Mar 2021 15:16:27 +0000 (UTC)
Date:   Wed, 3 Mar 2021 23:16:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
Message-ID: <YD+oSKPQJR2hl2ul@T590>
References: <347186099.14151179.1614497065881.JavaMail.zimbra@redhat.com>
 <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Feb 28, 2021 at 04:49:32AM -0500, Yi Zhang wrote:
> Hello
>=20
> I found this issue with blktests srp/015, could anyone help check it?
>=20
> [  250.415156] run blktests srp/015 at 2021-02-28 09:23:02
> [  250.525538] eno2 speed is unknown, defaulting to 1000
> [  250.530599] eno2 speed is unknown, defaulting to 1000
> [  250.535665] eno2 speed is unknown, defaulting to 1000
> [  250.541768] eno3 speed is unknown, defaulting to 1000
> [  250.546821] eno3 speed is unknown, defaulting to 1000
> [  250.551881] eno3 speed is unknown, defaulting to 1000
> [  250.557844] eno4 speed is unknown, defaulting to 1000
> [  250.562912] eno4 speed is unknown, defaulting to 1000
> [  250.567978] eno4 speed is unknown, defaulting to 1000
> [  250.573945] lo speed is unknown, defaulting to 1000
> [  250.578827] lo speed is unknown, defaulting to 1000
> [  250.583712] lo speed is unknown, defaulting to 1000
> [  250.605512] sd 15:0:0:0: Power-on or device reset occurred
> [  250.673453] device-mapper: table: 253:3: multipath: error getting devi=
ce
> [  250.680160] device-mapper: ioctl: error adding target to table
> [  250.732648] eno2 speed is unknown, defaulting to 1000
> [  250.737724] eno3 speed is unknown, defaulting to 1000
> [  250.742784] eno4 speed is unknown, defaulting to 1000
> [  250.747843] lo speed is unknown, defaulting to 1000
> [  250.752725] ib_srpt MAD registration failed for lo_siw-1.
> [  251.106511] scsi host16:   REJ reason 0xffffff98
> [  251.111150] scsi host16: ib_srp: Connection 0/4 to 10.16.221.116 failed
> [  251.246254] sd 16:0:0:0: Warning! Received an indication that the LUN =
assignments on this target have changed. The Linux SCSI layer does not auto=
matical
> [  251.260567] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  251.260765] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  251.280135] sd 16:0:0:1: Warning! Received an indication that the LUN =
assignments on this target have changed. The Linux SCSI layer does not auto=
matical
> [  251.298968] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  252.505389] ext4 filesystem being mounted at /root/blktests/results/tm=
pdir.srp.015.63f/mnt0 supports timestamps until 2038 (0x7fffffff)
> [  253.522565] device-mapper: table: 253:6: multipath: error getting devi=
ce
> [  253.529277] device-mapper: ioctl: error adding target to table
> [  257.526935] device-mapper: multipath: 253:4: Failing path 8:32.
> [  262.542076] scsi host16:   REJ reason 0xffffff98
> [  262.546708] scsi host16: ib_srp: Connection 0/4 to 10.16.221.116 failed
> [  262.671752] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  262.672079] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  262.692394] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  267.804429] device-mapper: multipath: 253:4: Failing path 8:32.
> [  267.882487] srpt_recv_done: 502 callbacks suppressed
> [  269.819904] scsi host16:   REJ reason 0xffffff98
> [  269.824533] scsi host16: ib_srp: Connection 0/4 to 10.16.221.116 failed
> [  269.951714] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  269.952049] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  269.972080] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  275.085527] device-mapper: multipath: 253:4: Failing path 8:32.
> [  275.152684] srpt_recv_done: 502 callbacks suppressed
> [  277.100827] scsi host16:   REJ reason 0xffffff98
> [  277.105452] scsi host16: ib_srp: Connection 0/4 to 10.16.221.116 failed
> [  277.231922] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  277.242758] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  277.252505] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  282.353149] device-mapper: multipath: 253:4: Failing path 8:32.
> [  282.419429] srpt_recv_done: 502 callbacks suppressed
> [  282.842310] scsi host17:   REJ reason 0xffffff98
> [  282.846939] scsi host17: ib_srp: Connection 0/4 to 10.16.221.116 failed
> [  282.981432] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  282.991501] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  283.001358] srpt/0xf0d4e2e6e1e000000000000000000000: Unsupported SCSI =
Opcode 0xa3, sending CHECK_CONDITION.
> [  284.690990] device-mapper: multipath: 253:4: Failing path 8:96.
> [  285.493848] BUG: unable to handle page fault for address: ffffffffc0a8=
9150
> [  285.500724] #PF: supervisor read access in kernel mode
> [  285.505863] #PF: error_code(0x0000) - not-present page
> [  285.511001] PGD 37bc13067 P4D 37bc13067 PUD 37bc15067 PMD 13839d067 PT=
E 0
> [  285.517789] Oops: 0000 [#1] SMP NOPTI
> [  285.521454] CPU: 31 PID: 17943 Comm: multipathd Tainted: G S        I =
      5.11.0 #4
> [  285.529279] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.=
0 11/12/2020
> [  285.536837] RIP: 0010:scsi_mq_exit_request+0x14/0x50
> [  285.541804] Code: 00 00 e9 bf eb 58 00 e9 ea bc e0 ff 66 2e 0f 1f 84 0=
0 00 00 00 00 0f 1f 44 00 00 53 48 8b 7f 60 48 89 f3 48 8b 87 98 00 00 00 <=
48> 8b 40 30 48 85 c0 74 0c 48 8d b6 10 01 00 00 e8 87 eb 58 00 f6
> [  285.560548] RSP: 0018:ffffa66e82e37c98 EFLAGS: 00010286
> [  285.565774] RAX: ffffffffc0a89120 RBX: ffff8a0e8a3e0000 RCX: 000000000=
0000000
> [  285.572906] RDX: 0000000000000000 RSI: ffff8a0e8a3e0000 RDI: ffff8a0e6=
92a1000
> [  285.580038] RBP: ffff8a0ea8469800 R08: 000000000000020d R09: 000000000=
002a780
> [  285.587170] R10: 00000376b4157308 R11: 0000000000000000 R12: 000000000=
0000000
> [  285.594304] R13: ffff8a0e692a10a8 R14: 0000000000000000 R15: ffff8a0e9=
244b700
> [  285.601435] FS:  00007f616c291700(0000) GS:ffff8a1d801c0000(0000) knlG=
S:0000000000000000
> [  285.609521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  285.615269] CR2: ffffffffc0a89150 CR3: 000000011e43e003 CR4: 000000000=
07706e0
> [  285.622401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  285.629532] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  285.636664] PKRU: 55555554
> [  285.639369] Call Trace:
> [  285.641824]  blk_mq_free_rqs+0x59/0xd0
> [  285.645573]  blk_mq_free_map_and_requests+0x31/0x60
> [  285.650454]  blk_mq_free_tag_set+0x22/0x80
> [  285.654553]  scsi_host_dev_release+0x86/0xe0
> [  285.658826]  device_release+0x33/0x90
> [  285.662490]  kobject_release+0x46/0x150
> [  285.666332]  device_release+0x33/0x90
> [  285.669995]  kobject_release+0x46/0x150
> [  285.673836]  execute_in_process_context+0x21/0x60
> [  285.678542]  device_release+0x33/0x90
> [  285.682208]  kobject_release+0x46/0x150
> [  285.686046]  scsi_disk_put+0x2b/0x40 [sd_mod]
> [  285.690406]  __blkdev_put+0x186/0x1b0
> [  285.694072]  blkdev_put+0x4c/0x110
> [  285.697476]  blkdev_close+0x21/0x30
> [  285.700970]  __fput+0x92/0x230
> [  285.704029]  task_work_run+0x70/0xb0
> [  285.707608]  exit_to_user_mode_prepare+0x150/0x160
> [  285.712402]  syscall_exit_to_user_mode+0x12/0x40
> [  285.717021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  285.722071] RIP: 0033:0x7f616b1ce977
> [  285.725652] Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 6=
6 90 53 89 fb 48 83 ec 10 e8 e4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 26 fc ff ff 8b 44 24
> [  285.744397] RSP: 002b:00007f616c28f7b0 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000003
> [  285.751962] RAX: 0000000000000000 RBX: 000000000000000b RCX: 00007f616=
b1ce977
> [  285.759094] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000=
000000b
> [  285.766227] RBP: 00005588a853efb0 R08: 0000000000000001 R09: 000000000=
0000007
> [  285.773359] R10: 0000000000000000 R11: 0000000000000293 R12: 00005588a=
8215b19
> [  285.780492] R13: 00007f615401d630 R14: 0000000000000001 R15: 00007f615=
401d630
> [  285.787624] Modules linked in: target_core_user uio target_core_pscsi =
target_core_file ib_srpt target_core_iblock target_core_mod scsi_debug siw =
null_blk ext4 mbcache jbd2 rpcrdma rdma_ucm ib_umad ib_iser libiscsi scsi_t=
ransport_iscsi rdma_cm iw_cm ib_cm ib_uverbs ib_core rfkill sunrpc vfat fat=
 dm_service_time dm_multipath intel_rapl_msr intel_rapl_common isst_if_comm=
on skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_s=
sif kvm mgag200 i2c_algo_bit drm_kms_helper iTCO_wdt iTCO_vendor_support ir=
qbypass dcdbas syscopyarea crct10dif_pclmul sysfillrect crc32_pclmul sysimg=
blt fb_sys_fops ghash_clmulni_intel drm acpi_ipmi rapl ipmi_si intel_cstate=
 dell_smbios dax_pmem_compat mei_me i2c_i801 ipmi_devintf device_dax intel_=
uncore mei wmi_bmof dell_wmi_descriptor pcspkr intel_pch_thermal lpc_ich i2=
c_smbus ipmi_msghandler dax_pmem_core acpi_power_meter ip_tables xfs libcrc=
32c nd_pmem nd_btt sd_mod t10_pi sg ahci libahci nfit megaraid_sas libata t=
g3 crc32c_intel libnvdimm wmi
> [  285.787672]  dm_mirror dm_region_hash dm_log dm_mod [last unloaded: sc=
si_transport_srp]
> [  285.882703] CR2: ffffffffc0a89150
> [  285.886032] ---[ end trace 718c96f79b0576a6 ]---
> [  285.896061] RIP: 0010:scsi_mq_exit_request+0x14/0x50
> [  285.901024] Code: 00 00 e9 bf eb 58 00 e9 ea bc e0 ff 66 2e 0f 1f 84 0=
0 00 00 00 00 0f 1f 44 00 00 53 48 8b 7f 60 48 89 f3 48 8b 87 98 00 00 00 <=
48> 8b 40 30 48 85 c0 74 0c 48 8d b6 10 01 00 00 e8 87 eb 58 00 f6
> [  285.919768] RSP: 0018:ffffa66e82e37c98 EFLAGS: 00010286
> [  285.924995] RAX: ffffffffc0a89120 RBX: ffff8a0e8a3e0000 RCX: 000000000=
0000000
> [  285.932128] RDX: 0000000000000000 RSI: ffff8a0e8a3e0000 RDI: ffff8a0e6=
92a1000
> [  285.939260] RBP: ffff8a0ea8469800 R08: 000000000000020d R09: 000000000=
002a780
> [  285.946394] R10: 00000376b4157308 R11: 0000000000000000 R12: 000000000=
0000000
> [  285.953524] R13: ffff8a0e692a10a8 R14: 0000000000000000 R15: ffff8a0e9=
244b700
> [  285.960658] FS:  00007f616c291700(0000) GS:ffff8a1d801c0000(0000) knlG=
S:0000000000000000
> [  285.968742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  285.974489] CR2: ffffffffc0a89150 CR3: 000000011e43e003 CR4: 000000000=
07706e0
> [  285.981623] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  285.988753] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  285.995885] PKRU: 55555554
> [  285.998590] Kernel panic - not syncing: Fatal exception
> [  286.504449] Kernel Offset: 0x2c200000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [  286.520574] ---[ end Kernel panic - not syncing: Fatal exception ]---
>=20
> (gdb) l *(scsi_mq_exit_request+0x14)
> 0xffffffff81673784 is in scsi_mq_exit_request (drivers/scsi/scsi_lib.c:17=
85).
> 1780					 unsigned int hctx_idx)
> 1781	{
> 1782		struct Scsi_Host *shost =3D set->driver_data;
> 1783		struct scsi_cmnd *cmd =3D blk_mq_rq_to_pdu(rq);
> 1784=09
> 1785		if (shost->hostt->exit_cmd_priv)
> 1786			shost->hostt->exit_cmd_priv(shost, cmd);

Looks it is weird since not see any drivers implement .exit_cmd_priv in
v5.11.

--=20
Ming

