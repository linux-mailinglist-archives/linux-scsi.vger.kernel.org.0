Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1B167FA4
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Feb 2020 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBUOIS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Feb 2020 09:08:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgBUOIS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Feb 2020 09:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vjr9XU8dUa6gzImAudlTMQVtlpwDQk2QEynsXr3wS0U=; b=XyM1/+bWH51aL9nPLuPRd8W4BD
        qWcwyBNRx/4/+2ypV7M68g50BOWPqqUfsRz46LWjWm9CVo1p0FkqavmfgOHg2ObWF9p67sQ3UE62U
        QlNDwxCGJPMCKZK6XnOKW1Rk0G0enrrZemtNcd83zPoIIjBTEdeWlbWakvIf2Y45F9wuGqeodncJX
        K0ewvFlIVyeQTevqVKKtXvNIdbzfFrcu9V31sSnHijrc2JeD8ubqHLehkCMru+8zdIohho1B9a5Lk
        PH+mD8RMz2zQ7uKYOKtrB14NbNwvAc0wgAtzDO+NxMIFUgGH9zDHG/tmxJCKQLpXCeZ3Wekn6uLQ4
        MEspy9zw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58yT-00078C-5Z; Fri, 21 Feb 2020 14:08:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-scsi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: ufshcd quirk cleanup v2
Date:   Fri, 21 Feb 2020 06:08:10 -0800
Message-Id: <20200221140812.476338-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

this removes lots of dead code from the ufs drivers, an cleans
up the quirk handling a little bit.

Changes since v1:
 - fix ufshcd_utrl_clear
 - minor cleanups
