Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274C1FC935
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQIs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Wed, 17 Jun 2020 04:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQIs5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:48:57 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 199435] HPSA + P420i resetting logical Direct-Access never
 complete
Date:   Wed, 17 Jun 2020 08:48:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: voronkovaa@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-199435-11613-UVW5fDr8bs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199435-11613@https.bugzilla.kernel.org/>
References: <bug-199435-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199435

Andrey Voronkov (voronkovaa@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |voronkovaa@gmail.com

--- Comment #35 from Andrey Voronkov (voronkovaa@gmail.com) ---
Hi guys, I'm from the future. It's 2020 already!
I have similar (exact the same?) problem with HPSA P410 already on two of my
nodes with Kernel 5.7.1-1.el7.elrepo.x86_64

Here are the logs:

2020-06-16T14:59:00.8117 warning kern kernel  [679613.058375] hpsa
0000:06:00.0: scsi 0:1:0:0: resetting logical  Direct-Access     HP      
LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
2020-06-16T14:59:23.3999 info kern kernel  [679635.647794] libceph: osd0 down
2020-06-16T14:59:23.3999 info kern kernel  [679635.648599] libceph: osd6 down
2020-06-16T14:59:24.4468 warning kern kernel  [679636.694762] rbd: rbd1:
encountered watch error: -107
2020-06-16T14:59:24.4886 warning kern kernel  [679636.736747] rbd: rbd2:
encountered watch error: -107
2020-06-16T14:59:28.4377 info kern kernel  [679640.685700] libceph: osd5 down
2020-06-16T14:59:36.6272 warning kern kernel  [679648.874179] hpsa
0000:06:00.0: Controller lockup detected: 0x0015002f after 30
2020-06-16T14:59:36.6272 warning kern kernel  [679648.875554] hpsa
0000:06:00.0: controller lockup detected: LUN:0000004000000000
CDB:01040000000000000000000000000000
2020-06-16T14:59:36.6272 warning kern kernel  [679648.875591] hpsa
0000:06:00.0: failed 15 commands in fail_all
2020-06-16T14:59:36.6272 warning kern kernel  [679648.876650] hpsa
0000:06:00.0: Controller lockup detected during reset wait
2020-06-16T14:59:36.6272 warning kern kernel  [679648.876655] hpsa
0000:06:00.0: scsi 0:1:0:0: reset logical  failed Direct-Access     HP      
LOGICAL VOLUME   RAID-0 SSDSmartPathCap- En- Exp=1
2020-06-16T14:59:36.6272 info kern kernel  [679648.876667] sd 0:1:0:2: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6272 info kern kernel  [679648.876672] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6348 info kern kernel  [679648.883168] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6348 info kern kernel  [679648.884214] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6357 info kern kernel  [679648.885286] sd 0:1:0:1: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6367 info kern kernel  [679648.886297] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6377 info kern kernel  [679648.887301] sd 0:1:0:2: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6395 info kern kernel  [679648.888269] sd 0:1:0:2: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6395 info kern kernel  [679648.889193] sd 0:1:0:3: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6419 info kern kernel  [679648.890076] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6419 info kern kernel  [679648.891496] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6447 info kern kernel  [679648.893012] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6447 info kern kernel  [679648.894114] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6466 info kern kernel  [679648.895182] sd 0:1:0:0: Device
offlined - not ready after error recovery
2020-06-16T14:59:36.6466 info kern kernel  [679648.896204] sd 0:1:0:2: [sdc]
tag#477 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=66s
2020-06-16T14:59:36.6489 info kern kernel  [679648.897223] sd 0:1:0:2: [sdc]
tag#477 CDB: Read(10) 28 00 00 ed 13 90 00 00 08 00
2020-06-16T14:59:36.6489 err kern kernel  [679648.898309] blk_update_request:
I/O error, dev sdc, sector 15537040 op 0x0:(READ) flags 0x0 phys_seg 1 prio
class 0
2020-06-16T14:59:36.6523 info kern kernel  [679648.899489] sd 0:1:0:0: [sda]
tag#469 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=70s
2020-06-16T14:59:36.6523 err kern kernel  [679648.899956] sd 0:1:0:0: rejecting
I/O to offline device
2020-06-16T14:59:36.6523 info kern kernel  [679648.900659] sd 0:1:0:0: [sda]
tag#469 CDB: Read(10) 28 00 14 78 2f e0 00 00 10 00
2020-06-16T14:59:36.6524 err kern kernel  [679648.901820] blk_update_request:
I/O error, dev sda, sector 929142240 op 0x0:(READ) flags 0x3000 phys_seg 1 prio
class 0
2020-06-16T14:59:36.6537 err kern kernel  [679648.903092] blk_update_request:
I/O error, dev sda, sector 343420896 op 0x0:(READ) flags 0x80700 phys_seg 2
prio class 0
2020-06-16T14:59:36.6537 info kern kernel  [679648.903138] sd 0:1:0:0: [sda]
tag#470 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=70s

-- 
You are receiving this mail because:
You are the assignee for the bug.
