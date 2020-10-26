Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDF299766
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgJZTvb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 15:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgJZTvb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 15:51:31 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775392076D;
        Mon, 26 Oct 2020 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741890;
        bh=AOMeeq2SMI01qVL8HXqf3EnvAIJJQDYsbPf6cOCaBb0=;
        h=From:To:Cc:Subject:Date:From;
        b=S1W6IvBZNYtXWiofei3HFIp7TQmIgczNWXIRiQ9RvyHep3IlQYJMbaQ53ZVCA/zRd
         E+yM+e8kgErvhtZPXEIn5dJ08zgkXHtmazDWgOw0CQ/SlkQgIfbJ9S/03pu58X6KyZ
         vlR4iHcdOh+pLmbCkqU1nTEyVyYBWCOX5qmHzqQw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: 
Date:   Mon, 26 Oct 2020 12:51:19 -0700
Message-Id: <20201026195124.363096-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Change log from v3:
 - use __ufshcd_release with a fix in __ufshcd_release

Change log from v2:
 - use active_req-- instead of __ufshcd_release to avoid UFS timeout

Change log from v1:
 - remove clkgating_enable check in __ufshcd_release
 - use __uhfshcd_release instead of active_req.


