Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B162E95D
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Nov 2022 00:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiKQXNP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Nov 2022 18:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiKQXNL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Nov 2022 18:13:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F176D493
        for <linux-scsi@vger.kernel.org>; Thu, 17 Nov 2022 15:13:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 090FEB82046
        for <linux-scsi@vger.kernel.org>; Thu, 17 Nov 2022 23:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6FF2C433D6
        for <linux-scsi@vger.kernel.org>; Thu, 17 Nov 2022 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668726785;
        bh=0M0nPyqqdcNriEoSYDCKoN2FXwEhVzQF4t6Ut75ZAMc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JL/9AmCZ1lHBYp1vBrFy9+C/oiQpQknoQPwv93mNKWfIXlDa1J+StT8N3VkFcVnCy
         s4zMU5PtnVvrAwza0YoLx+Gv83fTlaakkJvCw7ZAdPM8NLgRtNIoeg9iwxUPWQ1PND
         m4/uoMTz2TQJj//H/8EfY0ACBtbEcXrszj7gJrGX3SwsXEpcIv+H4+NxvBu3x80gWp
         WFntMN4k4v07OvHqbrOgIG/s8+bTrSxtvB3+z28FQtMfDhh8otk4xjyBzR0lL3b2ue
         EWCV6f30/zGGq7AkMXwJjl2ww2hsYAxFZVyYNzaQY7xBHJaBE4bfRs4thxegfe62ex
         cvdDO92bspvhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AC486C433E9; Thu, 17 Nov 2022 23:13:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 216696] Linux unusable upon plugging encrypted SanDisk Extreme
 55AE USB 3.0 SSD, causes xHCI controller crash and drops USB keyboard/mouse
Date:   Thu, 17 Nov 2022 23:13:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216696-11613-0ttUf9gMKo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216696-11613@https.bugzilla.kernel.org/>
References: <bug-216696-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216696

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Considering there is a page fault, did you already experiment with iommu=3D=
pt?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
