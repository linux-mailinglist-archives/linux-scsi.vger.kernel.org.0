Return-Path: <linux-scsi+bounces-3752-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458D891784
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Mar 2024 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918141C22964
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Mar 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC48F3A1D8;
	Fri, 29 Mar 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="r/rSvynl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E148787
	for <linux-scsi@vger.kernel.org>; Fri, 29 Mar 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711154; cv=none; b=t5aPLwnchOpdD2AlbmFwEgWGY/n5C9Qfe2E/EN6QpqCMOLOrjzZZOa/P1FyWWWcZN96tunC+L/Avg/tQVroUyHn1qhJ0rKHg9fB0R2aVkx4K8JcN1BEagLEQUmka4LGRHjvhG4Kr1tgczBSzsFDLGrjD8gOYjmZab3rzIGT2lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711154; c=relaxed/simple;
	bh=ZrviXutq2dr435AUYJjbLGSGv3c9p2DlZU+PRLOghiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxrtYrBeE9pLCSutCh8Runh2uFw55XsoJ6fX51bEA4+lQSw7zbRf1wpinmqCjxWCceyUFSqvauIbfMN+3aU9WFJgEySHK5gdLTnSKDzBbatBXU9JF3oRMto5ezReVZxNV+eemfiv2064Qq/JVPUwh/J7OENc3eUS617dGfsgbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=r/rSvynl; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1711710643;
	bh=ZrviXutq2dr435AUYJjbLGSGv3c9p2DlZU+PRLOghiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r/rSvynlz3W8TbpsIKNUWqG4mk9PVFbFdnEkeP9XdK9sUhhDuoKu4mgZI1Ehzjd0f
	 6fQqfxAzQcDAGh+z8nm9/E2+WF6pbbvYzGCXFN6TNl+txRZyzELTkJsZxjhOaBvu83
	 r4KbgLQ9PbwF+cPSXGnq22j2XNy2zRnnGaUWRJnc=
To: sachinp@linux.ibm.com
Cc: Alexander@wetzel-home.de,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	martin.petersen@oracle.com
Subject: Re: [powerpc] WARN at drivers/scsi/sg.c:2236 (sg_remove_sfp_usercontext)
Date: Fri, 29 Mar 2024 12:10:25 +0100
Message-ID: <20240329111025.9486-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <5375B275-D137-4D5F-BE25-6AF8ACAE41EF@linux.ibm.com>
References: <5375B275-D137-4D5F-BE25-6AF8ACAE41EF@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Following WARN_ON_ONCE is triggered while running LTP tests
> (specifically ioctl_sg01) on IBM Power booted with 6.9.0-rc1-next-20240328
>
> [   64.230233] ------------[ cut here ]------------
> [   64.230269] WARNING: CPU: 10 PID: 452 at drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x270/0x280 [sg]
> [   64.230302] Modules linked in: rpadlpar_io rpaphp xsk_diag nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding tls rfkill ip_set nf_tables nfnetlink sunrpc binfmt_misc pseries_rng vmx_crypto xfs libcrc32c sd_mod sr_mod t10_pi crc64_rocksoft_generic cdrom crc64_rocksoft crc64 sg ibmvscsi ibmveth scsi_transport_srp fuse
> [   64.230420] CPU: 10 PID: 452 Comm: kworker/10:1 Kdump: loaded Not tainted 6.9.0-rc1-next-20240328 #2
> [   64.230438] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_018) hv:phyp pSeries
> [   64.230449] Workqueue: events sg_remove_sfp_usercontext [sg]
> [   64.230468] NIP:  c008000015c34110 LR: c008000015c33ffc CTR: c0000000005393b0
> [   64.230485] REGS: c00000000c1efae0 TRAP: 0700   Not tainted  (6.9.0-rc1-next-20240328)
> [   64.230498] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44000408  XER: 00000000
> [   64.230535] CFAR: c008000015c3400c IRQMASK: 0
> [   64.230535] GPR00: c008000015c33ffc c00000000c1efd80 c008000015c58900 c00000000ca8ae98
> [   64.230535] GPR04: 00000000c0000000 0000000000000023 c000000007c2e000 0000000000000022
> [   64.230535] GPR08: 000000038a130000 0000000000000002 0000000000000000 c008000015c38bc0
> [   64.230535] GPR12: c0000000005393b0 c00000038fff3f00 c0000000001a2bac c000000007c7a9c0
> [   64.230535] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [   64.230535] GPR20: c00000038c3f3b00 c000000007c10030 c000000007c10000 c0000000901c0000
> [   64.230535] GPR24: 0000000000000000 c00000000ca8ae00 c0000000045a5805 c000000007c11330
> [   64.230535] GPR28: c00000038c3f3b00 c000000007c10080 c000000007c11328 c000000002fdee54
> [   64.230671] NIP [c008000015c34110] sg_remove_sfp_usercontext+0x270/0x280 [sg]
> [   64.230690] LR [c008000015c33ffc] sg_remove_sfp_usercontext+0x15c/0x280 [sg]
> [   64.230709] Call Trace:
> [   64.230716] [c00000000c1efd80] [c008000015c33ffc] sg_remove_sfp_usercontext+0x15c/0x280 [sg] (unreliable)
> [   64.230740] [c00000000c1efe40] [c00000000019337c] process_one_work+0x20c/0x4f4
> [   64.230767] [c00000000c1efef0] [c0000000001942fc] worker_thread+0x378/0x544
> [   64.230787] [c00000000c1eff90] [c0000000001a2cdc] kthread+0x138/0x140
> [   64.230801] [c00000000c1effe0] [c00000000000df98] start_kernel_thread+0x14/0x18
> [   64.230819] Code: e8c98310 3d220000 e8698010 480044bd e8410018 7ec3b378 48004ac9 e8410018 38790098 81390098 2c090001 4182ff04 <0fe00000> 4bfffefc 000247e0 00000000
> [   64.230857] ---[ end trace 0000000000000000 ]—
>
> This WARN_ON was introduced with
> commit 27f58c04a8f438078583041468ec60597841284d
>     scsi: sg: Avoid sg device teardown race
>
> Reverting the patch avoids the warning. The test case passes irrespective of the
> patch is present of not.
>

The new WARN_ON_ONCE is only an additional logic check. When it
triggers it also should trigger when you undo the rest of the change.

But when it triggers something with the driver logic must be off.
(Or my understanding of the intent of the code is worse than assumed:-)

Looking into the d_ref logic I see two additional problems not addressed
by the original patch when sg_add_sfp() fails:
 1) sg_open() is then also calling first scsi_device_put() and then
    sg_device_destroy() via kref_put(). That's the wrong order.

 2) When sg_add_sfp() fails we never call kref_get(&sdp->d_ref).
    Thus we shoud not call kref_get() here at all.

Thus your warning above could be triggered by an error within
sg_add_sfp(): In that case d_ref would already be zero when the code
gets to the warning.

Can you check the debug patch below and provide output?
When I'm right the warning should be gone and you should just get the
"Modification triggered" instead. When I'm wrong we should at least see,
how many references d_ref has left.

Alexander
---
 drivers/scsi/sg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index ff6894ce5404..1c27d5f8f384 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -373,7 +373,8 @@ sg_open(struct inode *inode, struct file *filp)
 	scsi_autopm_put_device(sdp->device);
 sdp_put:
 	scsi_device_put(sdp->device);
-	goto sg_put;
+	pr_warn("%s: Modification triggered\n", __func__);
+	return retval;
 }
 
 /* Release resources associated with a successful sg_open()
@@ -2233,7 +2234,8 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
+	if(WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1))
+		printk(KERN_WARNING "d_ref=%u\n", kref_read(&sdp->d_ref));
 	kref_put(&sdp->d_ref, sg_device_destroy);
 	scsi_device_put(device);
 	module_put(THIS_MODULE);
-- 
2.44.0


