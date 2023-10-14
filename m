Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B67C9487
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Oct 2023 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJNMOU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Oct 2023 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNMOT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 14 Oct 2023 08:14:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD98A9
        for <linux-scsi@vger.kernel.org>; Sat, 14 Oct 2023 05:14:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D3DCC433CB
        for <linux-scsi@vger.kernel.org>; Sat, 14 Oct 2023 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697285658;
        bh=5mp5veHWNZKt6BP4hELDLlVs50OadyLwp/GM3G8W+2s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k3OhPNpiSF6Hl4+Eq4XSZxL+in3MOsK8lQKeS/btnJ/Ubea7cxymX8uruuZv1DVSc
         mDC0EbStzYzDjBfwEaHkp8sworfVgt6GAYhC4niSwGxA7zVSlaxlVcS/k+asB2lJgY
         e9c+Md8SS0zGn+4Lyv18aS0YW2jKkPQ6xKdIV+WAj5xbvceYa1/SZP1n+b6GV6dKG6
         zseiaDgD/oJtk3oat7gt5eVKVwb9+b6pOUXhwsLG68nyM+G3TBVFq0/Om0RLn4O8p1
         A7yjtMw/IbkMi07wtlBsobnBtL1802YAFIhrHTmedmiN3EeI5u0yAI0+L/BYyprWkH
         eF74J9n5LJUJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3784AC53BCD; Sat, 14 Oct 2023 12:14:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 76681] Adaptec 7805H SAS HBA (pm80xx) cannot survive ACPI S3 or
 ACPI S4
Date:   Sat, 14 Oct 2023 12:14:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: risc4all@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-76681-11613-HPpobjvv8f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-76681-11613@https.bugzilla.kernel.org/>
References: <bug-76681-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D76681

--- Comment #3 from DE (risc4all@yahoo.com) ---
Hello guys,

There are some good news on this!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
