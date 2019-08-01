Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18FA7E1C9
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfHAR7b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 1 Aug 2019 13:59:31 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50238 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731616AbfHAR7a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:59:30 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E9A372871C
        for <linux-scsi@vger.kernel.org>; Thu,  1 Aug 2019 17:59:29 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id D8F2B2871F; Thu,  1 Aug 2019 17:59:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 188061] On quad port QLE2564 can't add in target only 2 ports
Date:   Thu, 01 Aug 2019 17:59:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-qla2xxx@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: QLOGIC QLA2XXX
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stefan.leitner@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-qla2xxx@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-188061-11613-7jE33njKJz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-188061-11613@https.bugzilla.kernel.org/>
References: <bug-188061-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=188061

Stefan Leitner (stefan.leitner@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |stefan.leitner@gmail.com

--- Comment #11 from Stefan Leitner (stefan.leitner@gmail.com) ---
This bug is still present on Linux 5.0

root@server:~# systool -c fc_host -v | grep port_name
    port_name           = "0x18b0024ffb7bbf7"
    port_name           = "0x118b0024ffb7bbf7"
    port_name           = "0x218b0024ffb7bbf7"
    port_name           = "0x318b0024ffb7bbf7"

So the numbering of the first port swallows the 0 - resulting in a 14 char
value.
Also port number 4 (0x318...) results in targetcli in a 
WWN not valid as: naa

While changing utils.py REGEXP to re.match("naa\.[1235][0-9a-fA-F]{15}$", wwn)
it helps to add the 3rd port it does not solve the problem for the port number
1 (0x18... - which should be 0x018...)

lspci -v

0f:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI
Express HBA (rev 02)
        Subsystem: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express
HBA (QLE2564 PCI Express to 8Gb FC Quad Channel)
        Flags: bus master, fast devsel, latency 0, IRQ 102, NUMA node 0
        I/O ports at 7000 [size=256]
        Memory at f7bf0000 (64-bit, non-prefetchable) [size=16K]
        Memory at f7a00000 (64-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at f7900000 [disabled] [size=256K]
        Capabilities: [44] Power Management version 3
        Capabilities: [4c] Express Endpoint, MSI 00
        Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [98] Vital Product Data
        Capabilities: [a0] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting <?>
        Kernel driver in use: qla2xxx
        Kernel modules: qla2xxx

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
