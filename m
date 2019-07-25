Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2664475503
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGYRCR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jul 2019 13:02:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbfGYRCR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jul 2019 13:02:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PFwrwl012159
        for <linux-scsi@vger.kernel.org>; Thu, 25 Jul 2019 13:02:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tyevg4a5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 25 Jul 2019 13:02:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 25 Jul 2019 18:02:12 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 18:02:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PH1sme25559420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:01:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0C8211C054;
        Thu, 25 Jul 2019 17:02:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB58011C04C;
        Thu, 25 Jul 2019 17:02:09 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.98.207])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 17:02:09 +0000 (GMT)
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
From:   Steffen Maier <maier@linux.ibm.com>
Subject: SCSI batching since next-20190723 seems to fail multipath table
 creation?
Date:   Thu, 25 Jul 2019 19:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072517-0016-0000-0000-000002962E09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072517-0017-0000-0000-000032F42A99
Message-Id: <3d70ae2c-10f0-a346-0cae-e0ece7215616@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250188
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Paolo,

Since next-20190723, multipath-tools cannot assemble (zfcp-attached) SCSI disks 
into pathgroups anymore.

Looking at the SCSI devices managed by multipath-tools, some paths have "alua" 
for the dh_handler sysfs attribute, while other paths to the same volumes have 
an unexpected "detached" for dh_handler.


[root@t35lp62:~](0)# uname -a
Linux t35lp62.lnxne.boe 5.3.0-rc1-next-20190724 #60 SMP Thu Jul 25 18:28:26 
CEST 2019 s390x s390x s390x GNU/Linux

[root@t35lp62:~](0)# multipathd -k'show topo'

[root@t35lp62:~](0)# multipath -d
: 36005076303ffd32700000000000045e0 undef IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 0:0:1:1088438341 sda 8:0   undef ready running
   `- 1:0:1:1088438341 sde 8:64  undef ready running
: 36005076303ffd32700000000000045e1 undef IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 0:0:1:1088503877 sdb 8:16  undef ready running
   `- 1:0:1:1088503877 sdf 8:80  undef ready running
: 36005076303ffd32700000000000045e2 undef IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 0:0:1:1088569413 sdc 8:32  undef ready running
   `- 1:0:1:1088569413 sdg 8:96  undef ready running
: 36005076303ffd32700000000000045e3 undef IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 0:0:1:1088634949 sdd 8:48  undef ready running
   `- 1:0:1:1088634949 sdh 8:112 undef ready running
: 3600507630bffc320000000000000507a undef IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 3:0:0:1081753680 sdj 8:144 undef ready running
   `- 2:0:0:1081753680 sdi 8:128 undef ready running
: 3600507630bffc320000000000000517a undef IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 3:0:0:1081753681 sdn 8:208 undef ready running
   `- 2:0:0:1081753681 sdm 8:192 undef ready running
: 3600507630bffc320000000000000507b undef IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 3:0:0:1081819216 sdl 8:176 undef ready running
   `- 2:0:0:1081819216 sdk 8:160 undef ready running
: 3600507630bffc320000000000000517b undef IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=undef
`-+- policy='service-time 0' prio=50 status=undef
   |- 3:0:0:1081819217 sdo 8:224 undef ready running
   `- 2:0:0:1081819217 sdp 8:240 undef ready running

> [    5.869046] sd 2:0:0:1081819216: [sdk] tag#1905 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    5.869048] sd 2:0:0:1081819216: [sdk] tag#1905 CDB: Inquiry 12 01 c9 00 fe 00
> [    5.869050] sd 2:0:0:1081819216: [sdk] tag#1905 Sense Key : Illegal Request [current]
> [    5.869052] sd 2:0:0:1081819216: [sdk] tag#1905 Add. Sense: Invalid field in cdb
> [    5.869263] sd 2:0:0:1081819216: [sdk] tag#1908 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    5.869265] sd 2:0:0:1081819216: [sdk] tag#1908 CDB: Inquiry 12 01 c9 00 fe 00
> [    5.869267] sd 2:0:0:1081819216: [sdk] tag#1908 Sense Key : Illegal Request [current]
> [    5.869269] sd 2:0:0:1081819216: [sdk] tag#1908 Add. Sense: Invalid field in cdb
> [    5.871064] sd 2:0:0:1081819217: [sdp] tag#1913 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    5.871066] sd 2:0:0:1081819217: [sdp] tag#1913 CDB: Inquiry 12 01 c9 00 fe 00
> [    5.871068] sd 2:0:0:1081819217: [sdp] tag#1913 Sense Key : Illegal Request [current]
> [    5.871070] sd 2:0:0:1081819217: [sdp] tag#1913 Add. Sense: Invalid field in cdb
> [    5.871252] sd 2:0:0:1081819217: [sdp] tag#1915 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    5.871254] sd 2:0:0:1081819217: [sdp] tag#1915 CDB: Inquiry 12 01 c9 00 fe 00
> [    5.871256] sd 2:0:0:1081819217: [sdp] tag#1915 Sense Key : Illegal Request [current]
> [    5.871258] sd 2:0:0:1081819217: [sdp] tag#1915 Add. Sense: Invalid field in cdb

above errors are normal and they also occur without bad effect with the working 
kernel further down

the actual problems start here:

> [    5.877048] device-mapper: multipath service-time: version 0.3.0 loaded
> [    5.877138] device-mapper: table: 252:0: multipath: error attaching hardware handler
> [    5.877140] device-mapper: ioctl: error adding target to table
> [    5.882908] device-mapper: table: 252:0: multipath: error attaching hardware handler
> [    5.882911] device-mapper: ioctl: error adding target to table
> [    5.888344] device-mapper: table: 252:0: multipath: error attaching hardware handler
> [    5.888346] device-mapper: ioctl: error adding target to table
> [    5.895918] device-mapper: table: 252:0: multipath: error attaching hardware handler
> [    5.895920] device-mapper: ioctl: error adding target to table


Git bisect did not really converge (it had me test merge bases for too long so 
I gave up).

Looking at commits filtered to drivers/md (empty) and drivers/scsi, the 
following commits stood out to me:

9e5470fe2d61 ("scsi: virtio_scsi: implement request batching")
8930a6c20791 ("scsi: core: add support for request batching")

REBOOT into kernel with above commits reverted and now multipath assembly works 
again:

[root@t35lp62:~](0)# uname -a
Linux t35lp62.lnxne.boe 5.3.0-rc1noscsibatch-next-20190724+ #59 SMP Thu Jul 25 
18:24:23 CEST 2019 s390x s390x s390x GNU/Linux

[root@t35lp62:~](0)# multipathd -k'show topo'
create: 36005076303ffd32700000000000045e0 dm-0 IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 0:0:1:1088438341 sda 8:0   active ready running
   `- 1:0:0:1088438341 sde 8:64  active ready running
create: 36005076303ffd32700000000000045e1 dm-1 IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 0:0:1:1088503877 sdb 8:16  active ready running
   `- 1:0:0:1088503877 sdf 8:80  active ready running
create: 36005076303ffd32700000000000045e2 dm-3 IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 0:0:1:1088569413 sdc 8:32  active ready running
   `- 1:0:0:1088569413 sdg 8:96  active ready running
create: 36005076303ffd32700000000000045e3 dm-5 IBM,2107900
size=1.0G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 0:0:1:1088634949 sdd 8:48  active ready running
   `- 1:0:0:1088634949 sdh 8:112 active ready running
create: 3600507630bffc320000000000000507a dm-7 IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 2:0:0:1081753680 sdj 8:144 active ready running
   `- 3:0:0:1081753680 sdi 8:128 active ready running
create: 3600507630bffc320000000000000507b dm-9 IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 2:0:0:1081819216 sdk 8:160 active ready running
   `- 3:0:0:1081819216 sdl 8:176 active ready running
create: 3600507630bffc320000000000000517b dm-10 IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 2:0:0:1081819217 sdp 8:240 active ready running
   `- 3:0:0:1081819217 sdn 8:208 active ready running
3600507630bffc320000000000000517a dm-11 IBM,2107900
size=20G features='1 queue_if_no_path' hwhandler='1 alua' wp=rw
`-+- policy='service-time 0' prio=50 status=active
   |- 3:0:0:1081753681 sdm 8:192 active ready running
   `- 2:0:0:1081753681 sdo 8:224 active ready running

[root@t35lp62:~](0)# multipath -d

> [    7.892998] sd 2:0:0:1081753681: [sdo] tag#3696 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    7.893006] sd 2:0:0:1081753681: [sdo] tag#3696 CDB: Inquiry 12 01 c9 00 fe 00
> [    7.893009] sd 2:0:0:1081753681: [sdo] tag#3696 Sense Key : Illegal Request [current]
> [    7.893012] sd 2:0:0:1081753681: [sdo] tag#3696 Add. Sense: Invalid field in cdb
> [    7.893368] sd 2:0:0:1081753681: [sdo] tag#3697 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    7.893374] sd 2:0:0:1081753681: [sdo] tag#3697 CDB: Inquiry 12 01 c9 00 fe 00
> [    7.893377] sd 2:0:0:1081753681: [sdo] tag#3697 Sense Key : Illegal Request [current]
> [    7.893379] sd 2:0:0:1081753681: [sdo] tag#3697 Add. Sense: Invalid field in cdb
> [    7.898024] sd 2:0:0:1081753681: [sdo] tag#3699 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    7.898028] sd 2:0:0:1081753681: [sdo] tag#3699 CDB: Inquiry 12 01 c9 00 fe 00
> [    7.898031] sd 2:0:0:1081753681: [sdo] tag#3699 Sense Key : Illegal Request [current]
> [    7.898033] sd 2:0:0:1081753681: [sdo] tag#3699 Add. Sense: Invalid field in cdb
> [    7.898260] sd 2:0:0:1081753681: [sdo] tag#3700 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK
> [    7.898262] sd 2:0:0:1081753681: [sdo] tag#3700 CDB: Inquiry 12 01 c9 00 fe 00
> [    7.898264] sd 2:0:0:1081753681: [sdo] tag#3700 Sense Key : Illegal Request [current]
> [    7.898286] sd 2:0:0:1081753681: [sdo] tag#3700 Add. Sense: Invalid field in cdb
> [    7.898708] sd 2:0:0:1081753681: alua: supports implicit TPGS
> [    7.898714] sd 2:0:0:1081753681: alua: device naa.600507630bffc320000000000000517a port group 0 rel port 13
> [    7.911280] sd 2:0:0:1081753681: alua: port group 00 state A preferred supports tolusnA
> [    8.021240] sd 3:0:0:1081753681: alua: port group 00 state A preferred supports tolusnA
> [    8.021394] sd 3:0:0:1081753681: alua: port group 00 state A preferred supports tolusnA

I don't understand yet where those 2 commits would make a difference.


However, I also happened once to run into the following page fault with that 
kernel, so something else still seems odd:

> [  499.567828] sd 2:0:0:1088569413: Power-on or device reset occurred
> [  499.567838] sd 2:0:0:1088569413: [sdo] tag#3835 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> [  499.567842] sd 2:0:0:1088569413: [sdo] tag#3835 CDB: Test Unit Ready 00 00 00 00 00 00
> [  499.567844] sd 2:0:0:1088569413: [sdo] tag#3835 Sense Key : Unit Attention [current]
> [  499.567846] sd 2:0:0:1088569413: [sdo] tag#3835 Add. Sense: Power on, reset, or bus device reset occurred
> [  499.568912] sd 2:0:0:1088634949: Power-on or device reset occurred
> [  499.568921] sd 2:0:0:1088634949: [sdp] tag#3836 Done: ADD_TO_MLQUEUE Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> [  499.568922] sd 2:0:0:1088634949: [sdp] tag#3836 CDB: Test Unit Ready 00 00 00 00 00 00
> [  499.568924] sd 2:0:0:1088634949: [sdp] tag#3836 Sense Key : Unit Attention [current]
> [  499.568928] sd 2:0:0:1088634949: [sdp] tag#3836 Add. Sense: Power on, reset, or bus device reset occurred
> [  499.575352] Unable to handle kernel pointer dereference in virtual kernel address space
> [  499.575356] Failing address: 0000000000000000 TEID: 0000000000000887
> [  499.575357] Fault in home space mode while using kernel ASCE.
> [  499.575359] AS:000000003b410007 R3:000000005ffd0007 S:000000005ffd5000 P:000000000000013d
> [  499.575408] Oops: 0004 ilc:1 [#1] SMP
> [  499.575415] Modules linked in: xt_tcpudp(E) ip6t_rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(E) dm_service_time(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) s390_trng(E) ghash_s390(E) prng(E) aes_s390(E) des_s390(E) des_generic(E) sha512_s390(E) sha256_s390(E) sha1_s390(E) sha_common(E) eadm_sch(E) vfio_ccw(E) vfio_mdev(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) pkey(E) zcrypt(E) rng_core(E)
> [  499.575465] CPU: 3 PID: 1196 Comm: scsi_id Tainted: G            E     5.3.0-rc1noscsibatch-next-20190724+ #57
> [  499.575469] Hardware name: IBM 8561 T01 703 (LPAR)
> [  499.575470] Krnl PSW : 0404c00180000000 0000000000000000 (0x0)
> [  499.575476]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  499.575478] Krnl GPRS: 359e50c2000000af 0000000000000000 0000000049e86900 0000000049e86900
> [  499.575479]            000003e000cdba20 0000000000000018 000000004f5d5380 0000000049e287f8
> [  499.575481]            0000000049e28780 000003ff7cdc5300 0000000000000000 0000000049e86900
> [  499.575482]            0000000044c92000 00000000562ac400 000000003a78bc7a 000003e000cdb900
> [  499.575487] Krnl Code:>0000000000000000: 0000                illegal
> [  499.575487]            0000000000000002: 0000                illegal
> [  499.575487]            0000000000000004: 0000                illegal
> [  499.575487]            0000000000000006: 0000                illegal
> [  499.575487]            0000000000000008: 0000                illegal
> [  499.575487]            000000000000000a: 0000                illegal
> [  499.575487]            000000000000000c: 0000                illegal
> [  499.575487]            000000000000000e: 0000                illegal
> [  499.575495] Call Trace:
> [  499.575506] ([<000000003adea9d0>] str_spec.67320+0x1b8b54/0x1db64c)
> [  499.575517]  [<000000003a929768>] scsi_mq_done+0x48/0xd8
> [  499.575528]  [<000000003a9fb12c>] zfcp_fsf_fcp_cmnd_handler+0x13c/0x420
> [  499.575530]  [<000000003a9fbb50>] zfcp_fsf_req_complete+0xb8/0x798
> [  499.575532]  [<000000003a9fe20a>] zfcp_fsf_reqid_check+0xea/0x168
> [  499.575533]  [<000000003a9fe68e>] zfcp_qdio_int_resp+0x66/0x170
> [  499.575541]  [<000000003a98c284>] qdio_kick_handler+0x19c/0x298
> [  499.575542]  [<000000003a990226>] __tiqdio_inbound_processing+0x106/0xbf0
> [  499.575551]  [<000000003a1e4eea>] tasklet_action_common.isra.0+0x72/0xf0
> [  499.575559]  [<000000003aba5442>] __do_softirq+0x102/0x368
> [  499.575560]  [<000000003a1e4ab6>] irq_exit+0x9e/0xb8
> [  499.575563]  [<000000003a1a4558>] do_IRQ+0x78/0xb0
> [  499.575565]  [<000000003aba4708>] io_int_handler+0x124/0x28c
> [  499.575567] Last Breaking-Event-Address:
> [  499.575574]  [<000000003a78bc78>] blk_mq_complete_request+0xd8/0x158
> [  499.575580] Kernel panic - not syncing: Fatal exception in interrupt

Unfortunately, I could not collect a dump, so that's all debug data I have for 
the page fault.


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

