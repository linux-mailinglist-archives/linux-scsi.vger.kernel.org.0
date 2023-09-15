Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71847A2A3C
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Sep 2023 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjIOWKZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Sep 2023 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjIOWKP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Sep 2023 18:10:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34432B7
        for <linux-scsi@vger.kernel.org>; Fri, 15 Sep 2023 15:10:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3046C433C9
        for <linux-scsi@vger.kernel.org>; Fri, 15 Sep 2023 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694815810;
        bh=w4G50KyWOLBV+Raoa1iywbbe9JKoUXE6beB78C4HLQA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OqtBq+Pq9/QFUAFJzKUhAauHXHv+luUjnnuyuv47k+NBjLHx2wotWDRJME+o7WAqb
         O7IxZ8JLqZbx/rV4xKqVN5S3wagvBbaO588y1nh6V7jHRgL5gJIqPB0j3o8KK4xDt8
         40nITEcTVVeW+DqTT0bPYeQt04klsHVpkH8CcADXpa/AYIggTX7sA3H+vP6cc905Ie
         7QTyuABkqzheL/jIZTrPn0bQIAfL29fMzrXtRIRrfpXGUysNso69TCxwZQxA6LsnB9
         HhPpiF6wfjst+D6TmpkjtgYZeqLXRpXoXpYsirRDuMpdBs5Ga8CcpH2Hr2jbt8CSrn
         U3lLLdtD5OqxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B0BDBC53BCD; Fri, 15 Sep 2023 22:10:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 217914] scsi_eh_1 process high cpu after upgrading to 6.5
Date:   Fri, 15 Sep 2023 22:10:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: dlemoal@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217914-11613-KbjkItZEKj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217914-11613@https.bugzilla.kernel.org/>
References: <bug-217914-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217914

--- Comment #5 from dlemoal@kernel.org ---
On 9/16/23 07:01, Niklas Cassel wrote:
> On Fri, Sep 15, 2023 at 01:42:18PM -0700, Bart Van Assche wrote:
>> On 9/15/23 12:33, bugzilla-daemon@kernel.org wrote:
>>> The users loqs and leonshaw helped to narrow it down to this commit:
>>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D624885209f31eb9985bf51abe204ecbffe2fdeea
>>
>> Damien, can you please take a look?
>>
>=20
> Hello Bart,
>=20
> It seems like:
>
> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel=
.org/
>=20
> Solves the problem.
>=20
> From a quick look at the logs with extra log leves enabled:
> https://pastebin.com/f2LQ8kQD
> it appears that the MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES
> command with a non-zero service action issued by scsi_cdl_check() fails,
> and will be added to SCSI EH over and over.

The failure is due to the drive not liking this command. My patch avoids
sending
that command, thus solves the issue with drives that choke on it. However, =
the
constant retry sound to me like a different bug... We should not retry that
command at all I think. Or maybe limit it to 3 retries.

>=20
>=20
> Kind regards,
> Niklas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
