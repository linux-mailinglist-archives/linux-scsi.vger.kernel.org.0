Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F77AA2DE
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Sep 2023 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjIUVhh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Sep 2023 17:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjIUVhY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Sep 2023 17:37:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53D527F
        for <linux-scsi@vger.kernel.org>; Thu, 21 Sep 2023 14:13:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12337C433C8
        for <linux-scsi@vger.kernel.org>; Thu, 21 Sep 2023 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695330802;
        bh=+U9hcCnu59J1LgaG9sM42KIckRVPEEfa+aw1k2B9vjs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=shAYz+M4Oeru9+OntaVGMHXYXl4aJau/Opu/pzOA1A8+XUz/IojppNCM0mCu6jMGx
         r1G/wrO0JZ4Jm7znyeIz5vjN/5Q2TY332+KgOBV4rZZfwnsDce7RdHHFmTts+CsY/M
         M9AVxUW6cTuMOO6CkRTK4fSFL9GC9t7W0B3aQPpf2RtSxDb7qOOSlPhyLdDhdlOXkn
         IFAJkuCfdsKRo0pMpgKcLtUa5EZuLIIFyc6J61kZrS6tVmC0K6Fu8TQRRnn/V38UlS
         sboZIfcy6vo/RipVtkGgW4QHr/y/Mop4gDBKR4TMsV/tOzc9gcirambZ8ChmCNtGfA
         4zT1k5sQFljSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EC0EDC53BD1; Thu, 21 Sep 2023 21:13:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 215788] arcmsr driver on kernel 5.16 and up fails to initialize
 ARC-1280ML RAID controller
Date:   Thu, 21 Sep 2023 21:13:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iissmart@numberzero.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215788-11613-vlcy9MvcIW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215788-11613@https.bugzilla.kernel.org/>
References: <bug-215788-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215788

Ken Link (iissmart@numberzero.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |iissmart@numberzero.org

--- Comment #18 from Ken Link (iissmart@numberzero.org) ---
I am also experiencing this, on an Areca 1882ix-24 with firmware V1.56
2021-01-12 and arcmsr driver version v1.50.0X.14-20230614 in Ubuntu 22.04 on
kernel 6.2.0. I take it the 5.18/discovery branch hasn't been merged anywhe=
re
yet? What more testing needs to be done? How can I help?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
