Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4ED332484
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCILz1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Mar 2021 06:55:27 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:36443 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhCILyz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Mar 2021 06:54:55 -0500
Date:   Tue, 09 Mar 2021 11:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1615290891;
        bh=au8P311SmZ1/czCL4nVmAVr6ahOSI3lXF7J9b/rBkuk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ZDnc7rxJyrR4tLUITVTmEGkNJC1G99TX73DVWgs2x4rG6IxlowmqI5c0VPVhCYcWU
         I9ohzZ9o7wzYZ4MuD9RL9fSUsa4QZHoEjEixFgfqogtfipCP6p7XMU/GfsQdm2Vr+y
         Kw1WeWW+Zb1r33uGJYcru0g+u72zzvxeDgydatQY=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, ejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        cang@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org,
        asutoshd@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: v2: scsi: ufshcd: use a macro for UFS versions
Message-ID: <20210309115336.117206-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When using a device with UFS > 2.1 the error "invalid UFS version" is
misleadingly printed. There was a patch for this almost a year
ago to which this solution was suggested.

This series replaces the use of the growing UFSHCI_VERSION_xy macros with
an inline function to encode a major and minor version into the scheme
used on devices, that being:

        (major << 8) + (minor << 4)

I dealt with the different encoding used for UFS 1.x by converting it
to match the newer versions in ufshcd_get_ufs_version(). That means it's
possible to use comparisons for version checks, e.g.

        if (hba->ufs_version < ufshci_version(3, 0))
                ...

I've also dropped the "invalid UFS version" check entirely as it seems to
be more misleading than useful, and hasn't been accurate for a long time.

This has been tested on a device with UFS 3.0 and a device with UFS 2.1,
however I don't own any older devices to test with.

        Caleb
---
Changes since v1:
 * Switch from macro to static inline function
 * Address Christoph's formatting comments
 * Add Nitin's signoff on patch 3 ("scsi: ufshcd: remove version check")

Caleb Connolly (3):
      scsi: ufshcd: use a function to calculate versions
      scsi: ufs: qcom: use ufshci_version function
      scsi: ufshcd: remove version check

 drivers/scsi/ufs/ufs-qcom.c |  4 +--
 drivers/scsi/ufs/ufshcd.c   | 66 ++++++++++++++++++-----------------------=
----
 drivers/scsi/ufs/ufshci.h   | 17 +++++++-----
 3 files changed, 38 insertions(+), 49 deletions(-)



