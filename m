Return-Path: <linux-scsi+bounces-13541-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793BA94E37
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Apr 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E7C3B2E48
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Apr 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EA21420C;
	Mon, 21 Apr 2025 08:46:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF4189B84;
	Mon, 21 Apr 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225191; cv=none; b=eOYRbgLmvY2DQc53HO8++CdXW92mcGPq+HfLRcTiWVYFK2OFJh8+36zS0l984paGMmH0ErCRduTg+XG1vLE68vQH6tqW4GMM9LqOidpZjGx+1brN4wWSU0DCd+5wd5U+Zh/13f8ADE1VMFlx/OzQTD6E5Ma0DhX/vck1dSsftdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225191; c=relaxed/simple;
	bh=cJSMtwuJu5LqPw/IEGBrbSY+drfBvC3SbNAH2Z+4A28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjvC7qNHofdKMNyZ/fXFbroxPExrKOkl5u28l1INdRnshKCEIleKjXpRQcceOviy9OL0BNekJl0yNrOtGc8qcWYr89TzuPVqID9jcb5I/sDJbkhbYvxc+eziHmH8okgXKuWze2Ep2FcAxz1aYHMM9F4p0Bio94rnNCI0B/K1KWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 FA0858A479324C3AAB4B234475E5F826; Mon, 21 Apr 2025 15:16:11 +0700
From: Boris Belyavtsev <bbelyavtsev@usergate.com>
To: <hare@suse.com>
CC: <linux-scsi@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>,Boris Belyavtsev <bbelyavtsev@usergate.com>
Subject: [PATCH 6.1 v2 0/3] aic79xx: Add some non-NULL checks
Date: Mon, 21 Apr 2025 15:16:01 +0700
Message-ID: <20250421081604.655282-1-bbelyavtsev@usergate.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: 2A6D7501D800481AAB6C86A7878E2F79
X-MailFileId: BD91453ED87247A28CC07ED5908F62C7

Add non-NULL checks for ahd_lookup_scb return value.

scb could be NULL if faulty hardware return certain incorrect values to the
driver.

Changes in v2:
1. Reform cover letter text.
2. Fix the mess with style in v1.

Boris Belyavtsev (1):
  scsi: aic79xx: check for non-NULL scb in ahd_handle_seqint

Boris Belyavtsev (2):
  scsi: aic79xx: check for non-NULL scb in ahd_handle_pkt_busfree
  scsi: aic79xx: check for non-NULL scb in ahd_linux_queue_abort_cmd

 drivers/scsi/aic7xxx/aic79xx_core.c | 11 +++++++++--
 drivers/scsi/aic7xxx/aic79xx_osm.c  |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0


