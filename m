Return-Path: <linux-scsi+bounces-22948-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC0WEaQr32nOPgAAu9opvQ
	(envelope-from <linux-scsi+bounces-22948-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:09:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E66A400BEA
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F9D307C899
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3537F8A9;
	Wed, 15 Apr 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="duXVkIid"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89C3469E0;
	Wed, 15 Apr 2026 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233300; cv=none; b=odYiWeRLTo9TSKOqfofYDkRj0BoS6xIHAn0GSqWvvsopanY5Qxcnudpe6pArt6z58X3FF1z+QcLSWFqYTVffGxnZD1CYSUE0dlDb2x+Q1hwyHKN+RM/5LY3ZVe/mpCau4dtyjW64VdzLb4BtjlRQdbQOt7XDN7e3sRxqfUgdX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233300; c=relaxed/simple;
	bh=2ovhmzJhevm9MfhrfbCMJWV1Zxp/O/pGbsKc7wDsa5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt1wkkdBngkwAGno8J1asxX5KviUrZnODWbI7Qde5QjQml3AlTGfHcKFInzoNv5CXgH0Fj+7UK3SqY0yKRjDvuKzy05u0FgLegtE45pDGAl0c5SZUmYo4Wwlq9MlStWxxc+kNQ0IT0gTermMLsg/qr1lRB67/LgThnDhyE4chWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=duXVkIid; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0rHNfcbcjCzBHWTui/FHP/6IBr4fZAlw5QXqWD1nF3k=; b=duXVkIidvjIde01LJwlz9NUkf1
	UwchGb4GDVtRRFmpFeir4eogHWbYHbSYU3PWpx6vRnF8XULwCNWl79VoFV24CbAIAawNqZeUxSt83
	OnGIvBaI+O+59tpG8R2uCDa8lrMRDcR8bZbHv4xRG6jJ4KdVlgUKDTaGUmN15Oj3h8z26jdNv16pX
	mJOR9tzwWzKg7hhww7WBiFHlLrHE2zO+Rf+CWrN9TIvdH3m0gQ0J7Mde6DSv0RG4Wf0l/uRwhDveE
	X03MDQF+ZsLY4HZy4DnHKePtF9cBsA7p4UetQRMJBTnPlxwrJnkfLA50Cl3vTuJvo2b+UcdjNduld
	BEzGj3+Q==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCtQ9-00000000d2q-2U3J;
	Wed, 15 Apr 2026 06:08:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Doug Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: fix /dev/sg allocation failures register
Date: Wed, 15 Apr 2026 08:08:05 +0200
Message-ID: <20260415060813.807659-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22948-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E66A400BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Shin'ichiro reported trivially triggerable allocation failures when
using SG_IO on the sg driver.  This turn out to be caused by the
bio allocation rework, which makes non-blocking allocation fail
much easier.

This series has two independent patches to fix this from different
angles.  The first one changes the completely pointless GFP_ATOMIC
to use GFP_ATOMIC in sg.  The other drops the reduction of the gfp
mask in the bio allocator, so that atomic allocations of bios work
as expected, even if they are a pretty bad idea as the bio submission
actually needs a user context anyway.  The only other uses of this
seems to be the ocfs2 cluster managed.

