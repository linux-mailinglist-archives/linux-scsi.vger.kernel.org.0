Return-Path: <linux-scsi+bounces-22793-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 36KXAR9r02lViAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22793-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 10:13:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F83A2276
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B3B300EF4E
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2026 08:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9E2F39B9;
	Mon,  6 Apr 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b="mOd9A54y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b="BfpnDAq7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from aib29agb125.bom1.oracleemaildelivery.com (aib29agb125.bom1.oracleemaildelivery.com [192.29.172.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F714AD20
	for <linux-scsi@vger.kernel.org>; Mon,  6 Apr 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.172.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462883; cv=none; b=ePE9CsuBvBGQFJMHciGPuqm/BcwW15PAo+WLr3htDXnOCPdY9ueXNt6eS1aGdzQ3shMliiTAdDNyIcziztL/42DxUhQ/Zyv2355IZ5EN3mh9OW6m37RqAtBYzxHCX07KeOGj6qM/kFQfQ3I78fxiYyR8nH6m9J4Q/qh8dF4/WtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462883; c=relaxed/simple;
	bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
	h=From:To:Subject:Date:Message-id:MIME-version:Content-type; b=O3u+jH2TEAvQ2VRUrlzTm7hfvLtdsj32vCzEpOCZyS0PNxOZIaTs1dL7JGAc9wfNL4lUOc86i78NYwp4sw06LbbP3Ce34BjWjyDpacEOM/RZfA6+DxHhKZuexyBdPpnGUapyr7G+ojQTTsPCo0ywTY4LLFV2YyG1h9Vh8PnN6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b=mOd9A54y; dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b=BfpnDAq7; arc=none smtp.client-ip=192.29.172.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=smtp.linknsell.com.20250508;
 d=linknsell.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=mOd9A54yjFC57cLF8ctpOS+aDlAY7cIQHH1RWkvx72crgrbBP8QcajkOaydjq6tly0moC7RZlirn
   /+DytqGOD1Gr2/UIVUd3FlOnY8tvjpFfGcllsmH/Ib67rwIs1+B5bAikm1LKsXY01HAfpvqKc7Y7
   vOEXt7Hfm/6/2UDuvr18pSserS4wgHyUhK5vc5P6g1kZ4Lv3pRdN+MsSirvYUgsvgJWa56LLwj6O
   5gs0l9yDUwlCy8MG2x6tCP7EV5qnHJAVu1o15Svxy3Cx0VVK1SIxNBB3VkVth05eHgtsT7hquITE
   HNT3r9dyMJ0//1RX5xh4W3Izabes+dHT2RI9gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-bom-20200207;
 d=bom1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=BfpnDAq799cUPmqhDSbuzNx901kE5ad/4ZubELdvrWqQoh6grPq0Itbe9nVvcXqemeY5w88WxiGp
   vgfrR/hbZ9+tVrVAWBB8q3NHM/jlXjDzghDz1qCjmpHAC/EhKhRksJX7ypa6bIGKtqpHNg4HSCcc
   S6uFeMkEqrwbBXvbERWdMmsAB+DAA4uz5cH5plvIgPZsTWS0M1RYGw6EmG4SrjQeD3n3it8dgRk8
   BSUCsxOEQLl7pfSh50SnqPuAypj98GM5CgfLfZ2bfKZWUtIzfREw7BFDi6WjykrEXqIpSNEac24C
   n6dPnPMrtluwlAYn9KG2XJcN1sMErJoWznL1zw==
Received: by omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TD200HPFBXC2A70@omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com> for
 linux-scsi@vger.kernel.org; Mon, 06 Apr 2026 08:08:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Reply-to: jisunlee@gmilweb.com
From: Jisun Lee <NoReply@linknsell.com>
To: linux-scsi@vger.kernel.org
Subject: I need your help
Date: 6 Apr 2026 09:07:56 +0100
Message-id: <20260406075048.2801BF596C915189@linknsell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain;	charset="utf-8"
Content-transfer-encoding: quoted-printable
Reporting-Meta:
 AAFZ4Qxoyrv5K+2lYPZC9Mh2LCb8XPU7SkRF9j5w46KRuwxTYk0FUeFx2TevgHPv
 TnL/HTAqCHykhcMUTrDaSXL6V6yQSjsidAkPAtsGBTkrWHlODCBmlMvByXhkvNzR
 9tKMosH0KJ89c5AYZTLBTfzrlBzLL76nhu17Qiwa5s7R+EXMx7ADo16mgAgNpGzu
 sRb6v3DXPnGg+hz584sCApepDgwBUhXeeeikzQue8cgj6na1YKBJSMuY58jxJUZv
 ZL8PDTwKhkiJ/2DRBvLffabMMN0fYTaDr+t25Rwg1U17iQaxJTYBmX8dhG23ZAOW
 jk9/iCV9dzzMTSURAnR95lTvYXe4mFvzQK2OefjBrcMRswDpJxdHZK2GaqREkw6x
 NBj6w2lLsF+nbXfyHH7PPCpqN4q7dDqWhObqI+Vh5vYwq/bbfByVIUFDmP4ZdyVa
 od0OSr7D1kO3e504/M71O1Dqa+K1RWMEKv3cY6PLD6PVxr8E2hjwpIObIw==
X-Spamd-Result: default: False [14.34 / 15.00];
	FUZZY_DENIED(12.00)[1:12657554b7:1.00:bin];
	DMARC_POLICY_QUARANTINE(1.50)[linknsell.com : SPF not aligned (relaxed),quarantine];
	R_DKIM_REJECT(1.00)[linknsell.com:s=smtp.linknsell.com.20250508,bom1.rp.oracleemaildelivery.com:s=prod-bom-20200207];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22793-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[linknsell.com:-,bom1.rp.oracleemaildelivery.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[jisunlee@gmilweb.com];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.911];
	FROM_NEQ_ENVFROM(0.00)[NoReply@linknsell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmilweb.com:replyto,linknsell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A0F83A2276
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Dear Beloved

My ex Husband Song Lee refuse to pay our divorce settlement
funds. =E2=80=8BI need your help to recover Assets from the bank for=20
healthcare and child support
=E2=80=8Bpurposes, diagnosed with (bladder cancer).

=E2=80=8BI need your advise and support

=E2=80=8BThank You
Jisun Lee

