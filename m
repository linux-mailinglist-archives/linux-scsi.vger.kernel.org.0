Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB062EC07
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Nov 2022 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiKRCjl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Nov 2022 21:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRCjj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Nov 2022 21:39:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982464578
        for <linux-scsi@vger.kernel.org>; Thu, 17 Nov 2022 18:39:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88E6BCE1D58
        for <linux-scsi@vger.kernel.org>; Fri, 18 Nov 2022 02:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE7EC433B5
        for <linux-scsi@vger.kernel.org>; Fri, 18 Nov 2022 02:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668739174;
        bh=orLEWF0aALEbP731D8VcFuVYfhY18nHddLd97HmlMuA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BQTawmfaaIyi15BgusDg7DvUvLboylNwaK2q2CASeN1GavB/0E5I36gTzBQzYOav7
         t9XcOZics6Ns6V0FZorBqERnz2vMSvR6f35PPqW9Sg4talyvEKPD/2Uk/Xuk9IsAUc
         xpSEskBe7XEN+VrSKgJhotG+dEXLIAsN8Uj3TLPjprqa0K+Iorx46sf5qBF4eW1QzQ
         xqLj/0JqBnNKypLJR/O5tknxXjpLOx4W+vp/7Zme27D2mRW/7R6gHMnxL+8O8zEB/Z
         qKDNX6lso35X7uAzkzkP+MbPV3rGqChap0k+YwlF8h+I9kRcbXkFwRn986r5wE+Pup
         BATSgksKpcxug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9344BC433E9; Fri, 18 Nov 2022 02:39:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 216696] Linux unusable upon plugging encrypted SanDisk Extreme
 55AE USB 3.0 SSD, causes xHCI controller crash and drops USB keyboard/mouse
Date:   Fri, 18 Nov 2022 02:39:34 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216696-11613-MZlpCyLOQr@https.bugzilla.kernel.org/>
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

--- Comment #6 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
So you can see in there the IO_PAGE_FAULT and decode it using
https://www.amd.com/system/files/TechDocs/48882_3.07_PUB.pdf p149/p150.

The domain ID 0x18 is selected by the driver, I don't believe it's meaningf=
ul
in this case.  It seems to me that the device/driver for the device is caus=
ing
the XHCI controller to try to write to address 0xffcf0000.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
