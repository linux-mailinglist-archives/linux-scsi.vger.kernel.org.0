Return-Path: <linux-scsi+bounces-22468-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M7LNGzDwmmjlQQAu9opvQ
	(envelope-from <linux-scsi+bounces-22468-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Mar 2026 18:01:32 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36511319938
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Mar 2026 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E64D3305D421
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Mar 2026 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A8405ACE;
	Tue, 24 Mar 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcKEy/4A"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B91CFBA;
	Tue, 24 Mar 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371393; cv=none; b=Sn4abdWueFl6g8ytawTxpmK3F0clP3BabCNjod0uu3VNswT/2wwqAP2LUHTuKr29fUKEiXvr320T+kHH6XVAxZfsCuzOBhFL2bjkl7gUFsPOeIgoW51jOJcels4FTsN9UcG1AAIIE6HlUd/7zlVL8f+ITu2OXAVLsmUFsr70e6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371393; c=relaxed/simple;
	bh=PoOzE4bMRXwVPJ3HR6jRU+yQsIztZT8SIlqyurdOVh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EkzbHSO2VGwcV4Hl/EJB9Np0VI9kGIlrXImiTfE/PT/ctkQtClOk779xbSHiQna0cLuZW3yuCP7QkPwupC4oag8DfAz51wc3TaSamTJ+2N95nGQpH5QNMgy2u9wXJoFuYFX1jzqOgWMnYrswcKNXZUPgwcuQIuu8Amm7G7cxxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcKEy/4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A1B8C19424;
	Tue, 24 Mar 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371393;
	bh=PoOzE4bMRXwVPJ3HR6jRU+yQsIztZT8SIlqyurdOVh0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NcKEy/4AlD3D6xG7KtHEXgfhvX9Mp2ZrROzqOVm89oX018JO07h5gFBEkLB4moH8J
	 1hrb64V3sbI9h8x9FgixslFaWuom0KJbsxsoqV6hJFe3uVtyWP6JnzmvpQJw4dShTV
	 5ftrxGRHttL3ntljw+OYfxeQbpRSrC2oVtXP86T7ewyzgXrBD96jih5w1dij+HNvrC
	 13Ho1UBZYxf3lrvaEHVfdaekxrVvCJFyLkAjD2VXuT9fu0eaSUZJlmi2Fz5N4x9xPs
	 9yeH/I15ZcL4c+qjQk1+9px8gl4fCgl62xVlWpgfDdDz880NiUyP/eZVnL09YNstvg
	 2K0g74tnYoElw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C73F54ADE;
	Tue, 24 Mar 2026 16:56:33 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Mar 2026 11:56:25 -0500
Subject: [PATCH] scsi: fix typo in fc_els.h
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-fix-typo-v1-1-601f4fde35bc@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBAG0Ks0s9ak2pJwFbGgHYwFTYuQxt0Vy
 5fvJ0JATxigZhE8HhRoXRLyjIGZumVETjYZpJClUFLzgU6+XW7lhUIpVKVR2RJS3XlM2XfVtL/
 D3s9otncP9/0AKDPXhGwAAAA=
X-Change-ID: 20260324-fix-typo-53e20394e3d6
To: Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774371393; l=950;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=4bBSPr33ggF6ln+jKg0/Xc7FNaPHwzq2SefmglZHvvY=;
 b=4z5IUxOzgYIXHFEbUgF6NgeEYqU+atJYRwJl9jnSo7F9OBEz0ukgME9p7nqkPZxSwphA6vnY1
 QDk2Kg0y3bUBd50SgBLstYM2IiQfmVHseLpow5QCjydx9WXYpmccKRO
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22468-lists,linux-scsi=lfdr.de,davemarq.linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[davemarq@linux.ibm.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:replyto,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 36511319938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dave Marquardt <davemarq@linux.ibm.com>

Changed "caause" to "cause".

---
Fixed spelling error in fe_els.h.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 include/uapi/scsi/fc/fc_els.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
index 019096beb179..dca6a28f4e86 100644
--- a/include/uapi/scsi/fc/fc_els.h
+++ b/include/uapi/scsi/fc/fc_els.h
@@ -1030,7 +1030,7 @@ struct fc_fn_li_desc {
 					 */
 	__be32		event_count;	/* minimum number of event
 					 * occurrences during the event
-					 * threshold to caause the LI event
+					 * threshold to cause the LI event
 					 */
 	__be32		pname_count;	/* number of portname_list elements */
 	__be64		pname_list[];	/* list of N_Port_Names accessible

---
base-commit: 01f784fc9d0ab2a6dac45ee443620e517cb2a19b
change-id: 20260324-fix-typo-53e20394e3d6

Best regards,
--  
Dave Marquardt <davemarq@linux.ibm.com>



