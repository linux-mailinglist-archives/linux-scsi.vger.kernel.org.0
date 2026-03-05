Return-Path: <linux-scsi+bounces-21526-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEBbO78Lqmn0KAEAu9opvQ
	(envelope-from <linux-scsi+bounces-21526-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 00:03:27 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F121927B
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 00:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00DE830480E0
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2026 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D6282F19;
	Thu,  5 Mar 2026 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOIfHqAO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CC1F4CA9;
	Thu,  5 Mar 2026 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751709; cv=none; b=OnJghLrQtKtswbc4ARAZwp1kGH0HUeJjewgNZo9GtseJ236u/IMd2/nDxgt6gaz43JF04ODu9eOhqNu9HxUOOzTTRWqkopuOYPgvNGJcj5O1FD0qD0Ti5mJuDu+8+CsbTVKj8I4R+TDK+b0BK9SJJ4kzQ3bJyVwqq7nChlEkGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751709; c=relaxed/simple;
	bh=XETZmt/ZEJx0r+XYBiPTgV9mCSBd3IrEzAmVWfBnZsg=;
	h=To:Cc:Message-ID:From:Subject:Date; b=PC/9B4BKWGFDv0nZZHCeDtuxiNwiiJzFWyYnilpXrEAXESxGSh2sBbV+yw7PfWYI+IRWJMT1M49+BMt6xQpF9gnNlbKAVuxAdejlabEvqn4F5jfcLEMZdpyp8GFd3QSQaSiS9eLPgCGyHpk72GlEswPXK31LVmFdackBgms3Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOIfHqAO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D8E2EC0084;
	Thu,  5 Mar 2026 18:01:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 18:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772751705; x=1772838105; bh=tJRv/tg4/k+69VMmc6YQYggL3mVU
	mTf0EUVNr4buHhs=; b=HOIfHqAOuf5vZeNXDJlDNOdSq0IuXRPNiYm4x+PgISYh
	VlXyaeVGxI8MLER7DYKmV0e9mPHhsZDUCq0Bs1FzQF9ACa6AfNVXoR7KeBLXDNFw
	Kwc9OIp7DO2tVxNfM/sBt2fup5ywIJyVYTW2md1wOj+gXjyxx0LFICOZRFw01aIx
	DDK/eltnRagNaEqnUtsDlNgbYsErSoYBFzrFgoyss/1XXlv/l0OFcsdXwUTnk2ao
	FnMupSi4EHcjLY5N3a7rTsyJJBghDt3EePpMysMSekPzAA6Rmv/VORPQTn/OvQRV
	+QQJzvbWSf/HqiAWDlMfEKODsKgZMaEbbpxY+Gw2SQ==
X-ME-Sender: <xms:WAuqaWyFCI_4w0NDu0NX5NJ9oWjHFM6lHp6PX7Lo7zNmLSrO77OJBQ>
    <xme:WAuqaYROEg9U_yaxfTp48lskL3YoQBIWA9_IdQZt46GGRuopAk46OlUBWT9_4aIcj
    ueUDRD3VqeCQDmtie-BPIgC3rZbXOvSElNoPK9MMFtzx8Oorb1F04U>
X-ME-Received: <xmr:WAuqaTJvxkrIgTlhtySk3ouPaTq975RP10_lXNXMedDC8VlJ0kfUPQ-qnAsyCwOzZfEfhRgfOc0k4Tj-tysXFqLCXhYepDlIEF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekffejgfehheehkeekffffveekteevvddvveelhffgffetteefgfeutdehleetheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnjh
    grvhgrlhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepghhrqdhqlhhoghhitgdq
    shhtohhrrghgvgdquhhpshhtrhgvrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
    epjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdr
    tghomhdprhgtphhtthhopehmrghrthhinhdrphgvthgvrhhsvghnsehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehtohhnhigssegthigsvghrnhgvthhitghsrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhinhhugidqmheikehksehl
    ihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstg
    hsihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WAuqafVU7r5pjIQGszhIDxtolC-VQG4u3ngRZL6m4FPiVXAq0KNJzA>
    <xmx:WAuqaXQMJb0VJyYVzdKLezkq4z45kDHgP2DPlAKshlc50M3CYZsDpQ>
    <xmx:WAuqaXALX0duMlYG8CLwptbHsE59OLUyprgXjnlPVYflJksbFz4XNw>
    <xmx:WAuqaWLCTGpQraCgQkaP24YpPDfLK1RzGCxpCCJvWltaP_sKU1yMog>
    <xmx:WQuqabE4ZgHZ4wcTxWXu_3LPVnen2tdNM1G6bjrOiAE2H6oIfQUPJt8t>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:01:42 -0500 (EST)
To: Nilesh Javali <njavali@marvell.com>,
    GR-QLogic-Storage-Upstream@marvell.com,
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tony Battersby <tonyb@cybernetics.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-m68k@lists.linux-m68k.org,
    linux-scsi@vger.kernel.org,
    linux-kernel@vger.kernel.org
Message-ID: <550e7d7bb8c2620ca4f6c9e809a4f853bdfa4c67.1772751689.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] scsi: qla2xxx: Remove problematic BUILD_BUG_ON() assertion
Date: Fri, 06 Mar 2026 10:01:29 +1100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 521F121927B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21526-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,linux-scsi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:mid,linux-m68k.org:email,messagingengine.com:dkim,intel.com:email,cybernetics.com:email,arndb.de:email,linux-foundation.org:email]
X-Rspamd-Action: no action

The LKP bot reported a build failure with CONFIG_COLDFIRE=y together with
CONFIG_SCSI_QLA_FC=y, that's attributable to the BUILD_BUG_ON() in
qlt_queue_unknown_atio().

That function uses kzalloc() to obtain memory for the following struct,
plus some extra bytes at the end.

struct qla_tgt_sess_op {
        struct scsi_qla_host *vha;
        uint32_t chip_reset;
        struct work_struct work;
        struct list_head cmd_list;
        bool aborted;
        struct rsp_que *rsp;

        struct atio_from_isp atio;
        /* DO NOT ADD ANYTHING ELSE HERE - atio must be last member */
};

The location of the 'atio' member is subsequently used as the destination
for a memcpy() that's expected to fill in the extra bytes beyond the end
of the struct.

That explains the loud warning in the comment above, which ought to be
sufficient to prevent some newly-added member from accidentally getting
clobbered. But, in case that warning was missed somehow, we also have the
failing assertion,

BUILD_BUG_ON(offsetof(struct qla_tgt_sess_op, atio) + sizeof(u->atio) !=
             sizeof(*u));

Unfortunately, this size assertion doesn't guarantee that 'atio' is the
last member. Indeed, adding a zero-length array member at the end does
not increase the struct size.

Moreover, this assertion can fail even when 'atio' really is the last
member, and that's what happened with commit e428b013d9df ("atomic:
specify alignment for atomic_t and atomic64_t"), which added 2 bytes of
harmless padding to the end of the struct.

Remove the problematic assertion. The comments alone should be enough to
prevent mistakes.

Cc: Tony Battersby <tonyb@cybernetics.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-m68k@lists.linux-m68k.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603030747.VX0v4otS-lkp@intel.com/
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
I don't know of a good way to encode an invariant like "the last member of
struct qla_tgt_sess_op is named atio" such that it might be statically
checked. But perhaps there is a good way to do that (?)

There's no Fixes tag here because there's no need to backport.
The BUILD_BUG_ON() comes from commit 091719c21d5a ("scsi: qla2xxx: target:
Fix invalid memory access with big CDBs") which appeared in v6.19-rc1.
The build failure first appeared in v7.0-rc1 with commit e428b013d9df
("atomic: specify alignment for atomic_t and atomic64_t").
---
 drivers/scsi/qla2xxx/qla_target.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index d772136984c9..06c1f3b577c4 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -213,7 +213,6 @@ static void qlt_queue_unknown_atio(scsi_qla_host_t *vha,
 	unsigned int add_cdb_len = 0;
 
 	/* atio must be the last member of qla_tgt_sess_op for add_cdb_len */
-	BUILD_BUG_ON(offsetof(struct qla_tgt_sess_op, atio) + sizeof(u->atio) != sizeof(*u));
 
 	if (tgt->tgt_stop) {
 		ql_dbg(ql_dbg_async, vha, 0x502c,
-- 
2.49.1


