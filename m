Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A0277D9F
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Sep 2020 03:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgIYB2o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Sep 2020 21:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgIYB2k (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 24 Sep 2020 21:28:40 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2035320809;
        Fri, 25 Sep 2020 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600997319;
        bh=5VtJpDdYtCwZlRfMorsUAUPg+YDyujpIPaxXRnHMyk0=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2UiWXKbQbJSc+yQpun/bDs5/NcjuHWRe9tkKiqGMHZlsgMmsEUVHZxP6nyGaRwqz
         fjBNTwUMIAfvc8HUBkRAqwFCDi5wsmzqbHq4zMENphEqDoacUDrKEuMFizuRcaTQgN
         L1kdPkolCTr9I1Rz5/vbo/g1Q2F2v5seKk7SWI6E=
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/3] zoned block device specific errors
Date:   Thu, 24 Sep 2020 18:28:35 -0700
Message-Id: <20200925012838.4043473-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Zone block devices may have some limits that require special handling.
This series provides a way for drivers to notify of these conditions.

v3 -> v4:

Added reviews/acks/sobs

Dropped unintended patch

Damien Le Moal (1):
  scsi: handle zone resources errors

Keith Busch (2):
  block: add zone specific block statuses
  nvme: translate zone resource errors

 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-core.c                    |  4 ++++
 drivers/nvme/host/core.c            |  4 ++++
 drivers/scsi/scsi_lib.c             |  9 +++++++++
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+)

-- 
2.24.1

