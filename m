Return-Path: <linux-scsi+bounces-18260-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A9BF2EE9
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Oct 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C255422CB1
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Oct 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90A3321A4;
	Mon, 20 Oct 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1ciRSDr4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DE19049B;
	Mon, 20 Oct 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984927; cv=none; b=D66ZCgAwBylRKFLMAHAkNniVV/ugxZBHFSiQYZ4NMU8npp3bub2BMMKKk/ZvRQ9Kekmvxx9+Xx+wLOpz5lEymOwRJ993SUmDL71h3gsr94PC8T8ylSzml8Ve7ffSIoCd3Pk4lLvNzwu00o/lKi3q7wjpuljC+gGl0DL8OxXiHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984927; c=relaxed/simple;
	bh=rc1swiYAYxHNyjCrrfclhSPeJC8etDxtJxwxDbqXt7s=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FN6iUWQmIAZ1gCE4wH0YFdqoMHmS8FPPGBnkq94ymfkmjQiyyORAmizjo6G9N09QcjUO6x9OPf7oyn6P6HH7HXAreN9shWToIvRYE0PiiAhBiuZGAqVQUZM7SULWgxoXOpnso7n7nU8uL31PTO5sYp2s5JSCkLc1KJfhaeLPUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1ciRSDr4; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cr3ph02vxzlmm81;
	Mon, 20 Oct 2025 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	in-reply-to:from:from:content-language:references:subject
	:subject:user-agent:mime-version:date:date:message-id
	:content-type:content-type:received:received; s=mr01; t=
	1760984922; x=1763576923; bh=9pFNOkF/1oSAPkmX+El2x60pfqx4xN/4bkF
	sTO6nUjw=; b=1ciRSDr4wOaiu2LVNOlTF1HyL0TZ1vAjAwcThFU1kEWhINxf+Gs
	1ATcwyAkBSMhmCOeAGzk3ap3GiJEj8g3KAjT3YCjoqArsgbg5lOLF62gmKGJXoeG
	Kwap6q0le/cQYvXhfDI5rm06I4mpiOoThVPjWiTzzMXtIIv/jzqnyMnqKpDVe5rB
	SnUbS33kCG6BO3jNdrD3GQg5BgM6T+RdG5fWcJIl3lVzCTX9WVMoj+rLO0gaPCGb
	lpi291HXiFAazdQGAtVXTXlHpU4wcQ1rPxU1x7RtPVdon5s13CxhBCSi+jF59+85
	xeLIdwLKBV+znLGx6diAt8WpiiON4K6GW0A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u2W5zNpratsG; Mon, 20 Oct 2025 18:28:42 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cr3pb1BbMzlssYR;
	Mon, 20 Oct 2025 18:28:37 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------6kCt2D9vxezGY8VX0Dq1DRFy"
Message-ID: <f8c1581f-5337-4473-b2a0-b1e1a9ee206e@acm.org>
Date: Mon, 20 Oct 2025 11:28:36 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 07/20] block/mq-deadline: Enable zoned write
 pipelining
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20251014215428.3686084-1-bvanassche@acm.org>
 <20251014215428.3686084-8-bvanassche@acm.org>
 <08ce89bb-756a-4ce8-9980-ddea8baab1d1@kernel.org>
 <a1850fbc-a699-4e73-9fb7-48d4734c6dd3@acm.org>
 <136efbd2-babc-4f07-871f-f1464a2ec546@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <136efbd2-babc-4f07-871f-f1464a2ec546@kernel.org>

This is a multi-part message in MIME format.
--------------6kCt2D9vxezGY8VX0Dq1DRFy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 10:31 PM, Damien Le Moal wrote:
> Maybe we need to rethink this, restarting from your main use case and why
> performance is not good. I think that said main use case is f2fs. So what
> happens with write throughput with it ? Why doesn't merging of small writes in
> the zone write plugs improve performance ? Wouldn't small modifications to f2fs
> zone write path improve things ?

F2FS typically generates large writes if the I/O bandwidth is high (100
MiB or more). Write pipelining improves write performance even for large
writes but not by a spectacular percentage. Write pipelining only
results in a drastic performance improvement if the write size is kept
small (e.g. 4 KiB).

> If the answers to all of the above is "no/does not work", what about a different
> approach: zone write plugging v2 with a single thread per CPU that does the
> pipelining without to force changes to other layers/change the API all over the
> block layer ?

The block layer changes that I'm proposing are small, easy to maintain
and not invasive. Using a mutex when pipelining writes only as I
proposed in a previous email is a solution that will yield better
performance than delegating work to another thread. Obtaining an
uncontended mutex takes less than a microsecond. Delegating work to
another thread introduces a delay of 10 to 100 microseconds.

> Unless you have a neat way to recreate the problem without Zoned UFS devices ?

This patch series adds support in both the scsi_debug and null_blk
drivers for write pipelining. If the mq-deadline patches from this 
series are reverted then the attached shell script sporadically reports
a write error on my test setup for the mq-deadline test cases.

Thanks,

Bart.
--------------6kCt2D9vxezGY8VX0Dq1DRFy
Content-Type: text/plain; charset=UTF-8; name="test-pipelining-zoned-writes"
Content-Disposition: attachment; filename="test-pipelining-zoned-writes"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZXUKCnJ1bl9jbWQoKSB7CiAgICBpZiBbIC16ICIkYW5kcm9p
ZCIgXTsgdGhlbgoJZXZhbCAiJCoiCiAgICBlbHNlCglhZGIgc2hlbGwgIiQqIgogICAgZmkK
fQoKdHJhY2luZ19hY3RpdmUoKSB7CiAgICBbICIkKHJ1bl9jbWQgImNhdCAvc3lzL2tlcm5l
bC90cmFjaW5nL3RyYWNpbmdfb24iKSIgPSAxIF0KfQoKc3RhcnRfdHJhY2luZygpIHsKICAg
IHJtIC1mICIkMSIKICAgIGNtZD0iKGlmIFsgISAtZSAvc3lzL2tlcm5lbC90cmFjaW5nL3Ry
YWNlIF07IHRoZW4gbW91bnQgLXQgdHJhY2VmcyBub25lIC9zeXMva2VybmVsL3RyYWNpbmc7
IGZpICYmCgljZCAvc3lzL2tlcm5lbC90cmFjaW5nICYmCglpZiBsc29mIC10IC9zeXMva2Vy
bmVsL3RyYWNpbmcvdHJhY2VfcGlwZSB8IHhhcmdzIC1yIGtpbGw7IHRoZW4gOjsgZmkgJiYK
CWVjaG8gMCA+IHRyYWNpbmdfb24gJiYKCWVjaG8gbm9wID4gY3VycmVudF90cmFjZXIgJiYK
CWVjaG8gPiB0cmFjZSAmJgoJZWNobyAwID4gZXZlbnRzL2VuYWJsZSAmJgoJZWNobyAxID4g
ZXZlbnRzL2Jsb2NrL2VuYWJsZSAmJgoJZWNobyAwID4gZXZlbnRzL2Jsb2NrL2Jsb2NrX2Rp
cnR5X2J1ZmZlci9lbmFibGUgJiYKCWVjaG8gMCA+IGV2ZW50cy9ibG9jay9ibG9ja190b3Vj
aF9idWZmZXIvZW5hYmxlICYmCglpZiBbIC1lIGV2ZW50cy9udWxsYiBdOyB0aGVuIGVjaG8g
MSA+IGV2ZW50cy9udWxsYi9lbmFibGU7IGZpICYmCgllY2hvIDEgPiB0cmFjaW5nX29uICYm
CgljYXQgdHJhY2VfcGlwZSkiCiAgICBydW5fY21kICIkY21kIiA+IiQxIiAmCiAgICB0cmFj
aW5nX3BpZD0kIQogICAgd2hpbGUgISB0cmFjaW5nX2FjdGl2ZTsgZG8KCXNsZWVwIC4xCiAg
ICBkb25lCn0KCmVuZF90cmFjaW5nKCkgewogICAgc2xlZXAgNQogICAgaWYgWyAtbiAiJHRy
YWNpbmdfcGlkIiBdOyB0aGVuIGtpbGwgIiR0cmFjaW5nX3BpZCI7IGZpCiAgICBydW5fY21k
ICJjZCAvc3lzL2tlcm5lbC90cmFjaW5nICYmCglpZiBsc29mIC10IC9zeXMva2VybmVsL3Ry
YWNpbmcvdHJhY2VfcGlwZSB8IHhhcmdzIC1yIGtpbGw7IHRoZW4gOjsgZmkgJiYKCWVjaG8g
MCA+L3N5cy9rZXJuZWwvdHJhY2luZy90cmFjaW5nX29uIgp9CgphbmRyb2lkPQpmYXN0ZXN0
X2NwdWNvcmU9Cm51bGxfYmxrPQp0cmFjaW5nPQoKd2hpbGUgWyAkIyAtZ3QgMCBdICYmIFsg
IiR7MSMtfSIgIT0gIiQxIiBdOyBkbwogICAgY2FzZSAiJDEiIGluCgktYSkKCSAgICBhbmRy
b2lkPXRydWU7IHNoaWZ0OzsKCS1uKQoJICAgIG51bGxfYmxrPXRydWU7IHNoaWZ0OzsKCS10
KQoJICAgIHRyYWNpbmc9dHJ1ZTsgc2hpZnQ7OwoJKikKCSAgICB1c2FnZTs7CiAgICBlc2Fj
CmRvbmUKCmlmIFsgLW4gIiR7YW5kcm9pZH0iIF07IHRoZW4KICAgIGFkYiByb290IDE+JjIK
ICAgIGFkYiBzaGVsbCAiZ3JlcCAtcSAnXlteWzpibGFuazpdXSogL3N5cy9rZXJuZWwvZGVi
dWcnIC9wcm9jL21vdW50cyB8fCBtb3VudCAtdCBkZWJ1Z2ZzIG5vbmUgL3N5cy9rZXJuZWwv
ZGVidWciCiAgICBhZGIgcHVzaCB+L3NvZnR3YXJlL2Zpby9maW8gL3RtcCA+Ji9kZXYvbnVs
bAogICAgYWRiIHB1c2ggfi9zb2Z0d2FyZS91dGlsLWxpbnV4L2Jsa3pvbmUgL3RtcCA+Ji9k
ZXYvbnVsbAogICAgZmFzdGVzdF9jcHVjb3JlPSQoYWRiIHNoZWxsICdncmVwIC1hSCAuIC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdVswLTldKi9jcHVmcmVxL2NwdWluZm9fbWF4X2Zy
ZXEgMj4vZGV2L251bGwnIHwKCQkgICAgICBzZWQgJ3MvOi8gLycgfAoJCSAgICAgIHNvcnQg
LXJuazIgfAoJCSAgICAgIGhlYWQgLW4xIHwKCQkgICAgICBzZWQgLWUgJ3N8L3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1fHw7c3wvY3B1ZnJlcS4qfHwnKQogICAgaWYgWyAteiAiJGZh
c3Rlc3RfY3B1Y29yZSIgXTsgdGhlbgoJZmFzdGVzdF9jcHVjb3JlPSQoKCQoYWRiIHNoZWxs
IG5wcm9jKSAtIDEpKQogICAgZmkKICAgIFsgLW4gIiRmYXN0ZXN0X2NwdWNvcmUiIF0KZmkK
CmZvciBtb2RlIGluICJub25lIDAiICJub25lIDEiICJtcS1kZWFkbGluZSAwIiAibXEtZGVh
ZGxpbmUgMSI7IGRvCiAgICBmb3IgZCBpbiAvc3lzL2tlcm5lbC9jb25maWcvbnVsbGIvKjsg
ZG8KCWlmIFsgLWQgIiRkIiBdICYmIHJtZGlyICIkZCI7IHRoZW4gOjsgZmkKICAgIGRvbmUK
ICAgIHJlYWQgLXIgaW9zY2hlZCBwcmVzZXJ2ZXNfd3JpdGVfb3JkZXIgPDw8IiRtb2RlIgog
ICAgaWYgWyAteiAiJGFuZHJvaWQiIF07IHRoZW4KCWlmIFsgLXogIiRudWxsX2JsayIgXTsg
dGhlbgoJICAgIHdoaWxlICEgbW9kcHJvYmUgLXIgc2NzaV9kZWJ1ZyA+Ji9kZXYvbnVsbDsg
ZG8KCQlzbGVlcCAuMQoJICAgIGRvbmUKCSAgICBwYXJhbXM9KAoJCW5kZWxheT0xMDAwMDAg
ICAgICAgICAgICAjIDEwMCB1cwoJCWhvc3RfbWF4X3F1ZXVlPTY0CgkJcHJlc2VydmVzX3dy
aXRlX29yZGVyPSIke3ByZXNlcnZlc193cml0ZV9vcmRlcn0iCgkJZGV2X3NpemVfbWI9MTAy
NCAgICAgICAgICMgMSBHaUIKCQlzdWJtaXRfcXVldWVzPSIkKG5wcm9jKSIKCQl6b25lX3Np
emVfbWI9MSAgICAgICAgICAgIyAxIE1pQgoJCXpvbmVfbnJfY29udj0wCgkJemJjPTIKCSAg
ICApCgkgICAgbW9kcHJvYmUgc2NzaV9kZWJ1ZyAiJHtwYXJhbXNbQF19IgoJICAgIHVkZXZh
ZG0gc2V0dGxlCgkgICAgZGV2PS9kZXYvJChjZCAvc3lzL2J1cy9wc2V1ZG8vZHJpdmVycy9z
Y3NpX2RlYnVnL2FkYXB0ZXIqL2hvc3QqL3RhcmdldCovKi9ibG9jayAmJiBlY2hvICopCgkg
ICAgYmFzZW5hbWU9JChiYXNlbmFtZSAiJHtkZXZ9IikKCWVsc2UKCSAgICBpZiBtb2Rwcm9i
ZSAtciBudWxsX2JsazsgdGhlbiA6OyBmaQoJICAgIG1vZHByb2JlIG51bGxfYmxrIG5yX2Rl
dmljZXM9MAoJICAgICgKCQljZCAvc3lzL2tlcm5lbC9jb25maWcvbnVsbGIKCQlta2RpciBu
dWxsYjAKCQljZCBudWxsYjAKCQlwYXJhbXM9KAoJCSAgICBjb21wbGV0aW9uX25zZWM9MTAw
MDAwICAgIyAxMDAgdXMKCQkgICAgaHdfcXVldWVfZGVwdGg9NjQKCQkgICAgaXJxbW9kZT0y
ICAgICAgICAgICAgICAgICMgTlVMTF9JUlFfVElNRVIKCQkgICAgbWF4X3NlY3RvcnM9JCgo
NDA5Ni81MTIpKQoJCSAgICBtZW1vcnlfYmFja2VkPTEKCQkgICAgcHJlc2VydmVzX3dyaXRl
X29yZGVyPSIke3ByZXNlcnZlc193cml0ZV9vcmRlcn0iCgkJICAgIHNpemU9MSAgICAgICAg
ICAgICAgICAgICAjIDEgR2lCCgkJICAgIHN1Ym1pdF9xdWV1ZXM9IiQobnByb2MpIgoJCSAg
ICB6b25lX3NpemU9MSAgICAgICAgICAgICAgIyAxIE1pQgoJCSAgICB6b25lZD0xCgkJICAg
IHBvd2VyPTEKCQkpCgkJZm9yIHAgaW4gIiR7cGFyYW1zW0BdfSI7IGRvCgkJICAgIGlmICEg
ZWNobyAiJHtwLy8qPX0iID4gIiR7cC8vPSp9IjsgdGhlbgoJCQllY2hvICIkcCIKCQkJZXhp
dCAxCgkJICAgIGZpCgkJZG9uZQoJICAgICkKCSAgICBiYXNlbmFtZT1udWxsYjAKCSAgICBk
ZXY9L2Rldi8ke2Jhc2VuYW1lfQoJICAgIHVkZXZhZG0gc2V0dGxlCglmaQoJWyAtYiAiJHtk
ZXZ9IiBdCglpZiBbICIke3ByZXNlcnZlc193cml0ZV9vcmRlcn0iID0gMSBdOyB0aGVuCgkg
ICAgcHp3PS9zeXMvY2xhc3MvYmxvY2svJHtiYXNlbmFtZX0vcXVldWUvcGlwZWxpbmVfem9u
ZWRfd3JpdGVzCgkgICAgaWYgWyAtZSAiJHB6dyIgXTsgdGhlbgoJCVsgIiQoPCIvc3lzL2Ns
YXNzL2Jsb2NrLyR7YmFzZW5hbWV9L3F1ZXVlL3BpcGVsaW5lX3pvbmVkX3dyaXRlcyIpIiA9
IDEgXQoJICAgIGZpCglmaQogICAgZWxzZQoJIyBSZXRyaWV2ZSB0aGUgZGV2aWNlIG5hbWUg
YXNzaWduZWQgdG8gdGhlIHpvbmVkIGxvZ2ljYWwgdW5pdC4KCWJhc2VuYW1lPSQoYWRiIHNo
ZWxsIGdyZXAgLWx2dyAwIC9zeXMvY2xhc3MvYmxvY2svc2QqL3F1ZXVlL2NodW5rX3NlY3Rv
cnMgMj4vZGV2L251bGwgfAoJCQkgICAgIHNlZCAnc3wvc3lzL2NsYXNzL2Jsb2NrL3x8Zztz
fC9xdWV1ZS9jaHVua19zZWN0b3JzfHxnJykKCSMgRGlzYWJsZSBibG9jayBsYXllciByZXF1
ZXN0IG1lcmdpbmcuCglkZXY9Ii9kZXYvYmxvY2svJHtiYXNlbmFtZX0iCiAgICBmaQogICAg
cnVuX2NtZCAiZWNobyA0MDk2ID4gL3N5cy9jbGFzcy9ibG9jay8ke2Jhc2VuYW1lfS9xdWV1
ZS9tYXhfc2VjdG9yc19rYiIKICAgICMgMDogZGlzYWJsZSBJL08gc3RhdGlzdGljcwogICAg
cnVuX2NtZCAiZWNobyAwID4gL3N5cy9jbGFzcy9ibG9jay8ke2Jhc2VuYW1lfS9xdWV1ZS9p
b3N0YXRzIgogICAgIyAyOiBkbyBub3QgYXR0ZW1wdCBhbnkgbWVyZ2VzCiAgICBydW5fY21k
ICJlY2hvIDIgPiAvc3lzL2NsYXNzL2Jsb2NrLyR7YmFzZW5hbWV9L3F1ZXVlL25vbWVyZ2Vz
IgogICAgIyAyOiBjb21wbGV0ZSBvbiB0aGUgcmVxdWVzdGluZyBDUFUKICAgIHJ1bl9jbWQg
ImVjaG8gMiA+IC9zeXMvY2xhc3MvYmxvY2svJHtiYXNlbmFtZX0vcXVldWUvcnFfYWZmaW5p
dHkiCiAgICBmb3IgaW9wYXR0ZXJuIGluIHdyaXRlIHJhbmR3cml0ZTsgZG8KCXBhcmFtcz0o
CgkgICAgLS1uYW1lPW1lYXN1cmUtaW9wcwoJICAgIC0tZmlsZW5hbWU9IiR7ZGV2fSIKCSAg
ICAtLWRpcmVjdD0xCgkgICAgLS1pb3NjaGVkdWxlcj0iJHtpb3NjaGVkfSIKCSAgICAtLWd0
b2RfcmVkdWNlPTEKCSAgICAtLXJ1bnRpbWU9MzAKCSAgICAtLXJ3PSIke2lvcGF0dGVybn0i
CgkgICAgLS10aHJlYWQ9MQoJICAgIC0tdGltZV9iYXNlZD0xCgkgICAgLS16b25lbW9kZT16
YmQKCSkKCWlmIFsgLW4gIiRmYXN0ZXN0X2NwdWNvcmUiIF07IHRoZW4KCSAgICBwYXJhbXMr
PSgtLWNwdXNfYWxsb3dlZD0iJHtmYXN0ZXN0X2NwdWNvcmV9IikKCWZpCglpZiBbICIkcHJl
c2VydmVzX3dyaXRlX29yZGVyIiA9IDEgXTsgdGhlbgoJICAgIHBhcmFtcys9KAoJCS0taW9l
bmdpbmU9bGliYWlvCgkgICAgKQoJICAgIHF1ZXVlX2RlcHRocz0oMSA2NCkKCWVsc2UKCSAg
ICBwYXJhbXMrPSgKCQktLWlvZW5naW5lPXB2c3luYzIKCSAgICApCgkgICAgcXVldWVfZGVw
dGhzPSgxKQoJZmkKCWZvciBxZCBpbiAiJHtxdWV1ZV9kZXB0aHNbQF19IjsgZG8KCSAgICBl
Y2hvICI9PT09IGlvc2NoZWQ9JGlvc2NoZWQgcHJlc2VydmVzX3dyaXRlX29yZGVyPSRwcmVz
ZXJ2ZXNfd3JpdGVfb3JkZXIgaW9wYXR0ZXJuPSR7aW9wYXR0ZXJufSBxZD0ke3FkfSIKCSAg
ICBwYXJhbXNfd2l0aF9xZD0oIiR7cGFyYW1zW0BdfSIpCgkgICAgcGFyYW1zX3dpdGhfcWQr
PSgiLS1pb2RlcHRoPSR7cWR9IikKCSAgICBpZiBbICIkcWQiICE9IDEgXTsgdGhlbgoJCXBh
cmFtc193aXRoX3FkKz0oLS1pb2RlcHRoX2JhdGNoPSQoKChxZCArIDMpIC8gNCkpKQoJICAg
IGZpCgkgICAgZWNobyAiZmlvICR7cGFyYW1zX3dpdGhfcWRbKl19IgoJICAgICMgUmVzZXQg
YWxsIG9wZW4gem9uZXMgdG8gcHJldmVudCB0aGF0IHRoZSBtYXhpbXVtIG51bWJlciBvZiBv
cGVuCgkgICAgIyB6b25lcyBpcyBleGNlZWRlZC4gTmV4dCwgbWVhc3VyZSBJT1BTLgoJICAg
IGlmIFsgLXogIiRhbmRyb2lkIiBdOyB0aGVuCgkJYmxrem9uZSByZXNldCAiJHtkZXZ9IgoJ
ICAgIGVsc2UKCQlhZGIgc2hlbGwgL3RtcC9ibGt6b25lIHJlc2V0ICIke2Rldn0iCgkgICAg
ZmkKCSAgICBpZiBbIC1uICIke3RyYWNpbmd9IiBdOyB0aGVuCgkJdHJhY2U9Ii90bXAvYmxv
Y2stdHJhY2UtJHtpb3NjaGVkfS0ke3ByZXNlcnZlc193cml0ZV9vcmRlcn0tJHtpb3BhdHRl
cm59LSR7cWR9LnR4dCIKCQlzdGFydF90cmFjaW5nICIke3RyYWNlfSIKCSAgICBmaQoJICAg
IHNldCArZQoJICAgIGlmIFsgLXogIiRhbmRyb2lkIiBdOyB0aGVuCgkJZmlvICIke3BhcmFt
c193aXRoX3FkW0BdfSIKCSAgICBlbHNlCgkJYWRiIHNoZWxsIC90bXAvZmlvICIke3BhcmFt
c193aXRoX3FkW0BdfSIKCSAgICBmaQoJICAgIHJldD0kPwoJICAgIHNldCAtZQoJICAgIGlm
IFsgLW4gIiR7dHJhY2luZ30iIF07IHRoZW4KCQllbmRfdHJhY2luZwoJCXh6IC05ICIke3Ry
YWNlfSIgJgoJICAgIGZpCgkgICAgWyAiJHJldCIgPSAwIF0gfHwgYnJlYWsKCSAgICBpZiBy
dW5fY21kICJjZCAvc3lzL2tlcm5lbC9kZWJ1Zy9ibG9jay8ke2Jhc2VuYW1lfSAmJiBpZiBn
cmVwIC1xICcgcmVmICcgem9uZV93cGx1Z3M7IHRoZW4gZ3JlcCAtYXZIICcgcmVmIDEgJyB6
b25lX3dwbHVnczsgZWxzZSBmYWxzZTsgZmkiOyB0aGVuCgkJZWNobwoJCWVjaG8gIkRldGVj
dGVkIG9uZSBvciBtb3JlIHJlZmVyZW5jZSBjb3VudCBsZWFrcyEiCgkJYnJlYWsKCSAgICBm
aQoJZG9uZQogICAgZG9uZQpkb25lCndhaXQK

--------------6kCt2D9vxezGY8VX0Dq1DRFy--

