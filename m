Return-Path: <linux-scsi+bounces-21383-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIryIHX7pmltbwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21383-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 03 Mar 2026 16:17:09 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C51F254E
	for <lists+linux-scsi@lfdr.de>; Tue, 03 Mar 2026 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98D7F30419FD
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Mar 2026 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84A48124D;
	Tue,  3 Mar 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w2VJMTJH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6544480968;
	Tue,  3 Mar 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550765; cv=none; b=AUwTr8JGF6lx+jOeYcFpG77d/jSopzdp9GvGxB9/HWN6jDcCTPai94KmLDVKAIqqwM0YvFDiOPkchQgXWyEk/pRgnFzWK4YXeptRyLbFaf/IbkwwC1HznvxN+ls85wPeP216DSD7baGtoMVO+lnwsOMRY7jn0c5zZGkXzQEe4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550765; c=relaxed/simple;
	bh=NfU/1dTyQmXum3B0dlA8jOt7Z0DxyhbIFonMoWODsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMemSq6mgxcp9ce2ITtbwtEh53p2M9tUB6d3R3F1Swe0VmtOOaarH7E4JpmJD8JGSnSJSLJx6MRqj1LN8u//3cy6xahOyeW0zy0MasrI0kldlnvsxMfHKpszWbWbyR9Ps0hdrk+6t7pF2U41gVzxJ5X7un6aSJiQGwofbtMpvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w2VJMTJH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NfU/1dTyQmXum3B0dlA8jOt7Z0DxyhbIFonMoWODsO8=; b=w2VJMTJH8sfOXo3GJ+xBDtAseM
	s538ltWvLppuQyW5CDP8ccFL5DyAztgpEu890YNuiMOmUAmUG5qiL7ZsT9Gho6Rv5YW9gFg/pFQrP
	CBtNMp3sH27e/WL6WRD/mefbrhSSYVVb05qrYvkOQxDCM9Ur/fmXQQWWvywk92GhXrAbvBmgcIJjl
	R9jbEXmXd15nHsHoEC3cmUEelxJUHh0Vwq/xI7Pipt23CXMZzRzLpsXH7Off47rfj5VrZbEgljSNX
	6jgBIZE7dbl9dCGMQeNZWwgj6QdhlgPDOXjhg4mJY05LVwaUnturLY+pzZIT46GK/FehmKLUx67eQ
	sdmzSWdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRQS-0000000FOlH-1dif;
	Tue, 03 Mar 2026 15:12:44 +0000
Date: Tue, 3 Mar 2026 07:12:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Fix missing lock when read async_scan in
 Scsi_Host
Message-ID: <aab6bMqPdO3rRP-N@infradead.org>
References: <20260302121343.1630837-1-wdhh6@aliyun.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302121343.1630837-1-wdhh6@aliyun.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 769C51F254E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[aliyun.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21383-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

No, using a lock to read a single scalar value makes zero sense.
Just switch to READ_ONCE/WRITE_ONCE to make alpha and KCSAN happy.


