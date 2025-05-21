Return-Path: <linux-scsi+bounces-14251-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9BABF8CC
	for <lists+linux-scsi@lfdr.de>; Wed, 21 May 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152613BCE83
	for <lists+linux-scsi@lfdr.de>; Wed, 21 May 2025 15:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7601FF1AD;
	Wed, 21 May 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTRFO3O6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B501E04AC;
	Wed, 21 May 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839416; cv=none; b=cUUdyY08Ti6upV94oWwGnwUY/cxAWAbcuMKJ/5TzfimfBCQGbFAFJzxeptp3DDJV8mqtUoArQq7rdWf4MN54KphLrQ+eeTX2ehvTXhQCxMw1qPnpANuiqWn4hZe00eTBIJHWYvicGvHbol/2V/KYw4xjfySY95S+9+8V+X/7VyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839416; c=relaxed/simple;
	bh=mr5CtfmCp0+Fg3KbvhDtMvPgXfFBME1nsOYjr9Lr5AM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIyuGT8KxzavpA5/VebTxQM/zGsZFyoBUBCaz/zU8Upm3xJUTA+sXUbbIRiuoPDL5PmlXSbBWNDdxhheHEFSG22+KLWKHs7v0COnx5U0wSsJr+QDF87VWS1m3wDK7WKYyBkSxu9Yy11bFHAEdMEj84LqlxoGHnjg5gxNBVwnG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTRFO3O6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acacb8743a7so1163157266b.1;
        Wed, 21 May 2025 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747839413; x=1748444213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mr5CtfmCp0+Fg3KbvhDtMvPgXfFBME1nsOYjr9Lr5AM=;
        b=eTRFO3O67WCUAPl4Zh/himyC+Nfh6aOUv54I4R93wBIeb2LKUZQdi/GgLpPEmQA/C6
         gQfFi9uQPy4ZNzUAZCWnVH94BuM17xzuNBOfl6chEU9gnX2vLSMnWigqQmowixhakGLt
         09Wa+CPwGFbYCrG+tccubIrAs5hksOM7WHmNLMrH6YqfHVxuIZQmbvak8QcMTqFMthew
         qBHRHXEaJ/zAt/Y/hW9a5/iwgvV9YH50lstZPR/S9UxWv1c+btef0E7ZeA16y/fPGbK2
         c9uMjR5JCgErQqkx1C+k0POQ1rndBaeCNRfJd0ewDZyl+1s8FTJINTdtYEBI+/LWg0Fh
         7Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839413; x=1748444213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mr5CtfmCp0+Fg3KbvhDtMvPgXfFBME1nsOYjr9Lr5AM=;
        b=SDn95Jq8VAor2ZcAjyU+fPfTym56WNaKBrp9nt0zRDBsSVUw1sI6ZyKJeDs6F1Q5F3
         FeUXxW/IWBEP0ucInaHrwtv8VOR7BJ5FiAMcbdaMb6NGdmptkYkaAd9jIP9eaI/ZbAl6
         yTxLhQEwVm5fIpJhSIYX/+Oi0J31Xas6hsXrZy69mDw/EmW18nZcw7wV92y/pswSkTow
         zAPPJg1wZuOWobUwZeUPJXx9nMj0PUnAUoT5+Xr+1Gb2R9W58Knt1cxAEuTzEomUkURR
         a03+m+f29AkdlGfG7tRi1Z3HsfhFEZUKILUPja/UFprYJGJJ+3qCFK7Ey7K1uupZS5Qw
         aAPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyKOZCiZxzg8nh76KP+wydkHbvu1yyoNE/kOJQkjLbeaNQrLsjegRIxPyQ1N8ypb6HOL1yIx464p6assw=@vger.kernel.org, AJvYcCVOiOvZ5vDwdBbhoiMUl4PAksOq+RN59/PwWNDQ3Y4Eh9TUxH89fMHsab4Iyhk19Amyn0swKEvSbgDApA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4oY8/0nLfc5GMR6yT03iFnYJ6m6bfcGSvTYyNZHycUmq/zdK
	/Nxhs8kmGMhvt9QYEi3h5kwlz31kNYs7+cugHrSS6Jv3a7aG/Qn7n3th
X-Gm-Gg: ASbGncsSkpFakXgT4Iy5pe7ajnwOrmkL9uN12NKSdA5vkeZ3FkL5LdMpnPsgUt3y9Gu
	9D/w9nBJZkaiziDFE61uBdRQc1jTegZi3xslHCWqzncWLaz59QXNwVKNg1ypGB9+bHbWX6elYly
	AIIOZnvwQ2loyjyXRCaaGemb0Wyf5Z7K3EfzdF+PG6HNiCILbvbkh+S9mDrgcDtGDJbF/Qo7Wwc
	wOjxD3dZQkAKeDOY775fqnS1zq1kLb74qxgV9Rz/zeSEwZ0hUEkgWV3LMj4AwAmSZMn5gMpYna3
	TMBHvV/5nVhLHsr9gPOkj65xIxxrYdgokWVTwGRA06rgqeSF0vwbXA==
X-Google-Smtp-Source: AGHT+IGa3r5Ooxfy9O+pD0KSbSNbuGHsQRY8f+56IAhxBCvhms08xP7u4zJuzcUr47n1DZbGzCGkvg==
X-Received: by 2002:a17:906:c113:b0:ad5:6174:f947 with SMTP id a640c23a62f3a-ad56174fbcdmr1332821766b.22.1747839412470;
        Wed, 21 May 2025 07:56:52 -0700 (PDT)
Received: from [10.176.234.34] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52cb1abc8sm903795466b.0.2025.05.21.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:56:51 -0700 (PDT)
Message-ID: <7e034db7e46a33287f59159401affd58a81abad6.camel@gmail.com>
Subject: Re: [PATCH v5] ufs: core: Add HID support
From: Bean Huo <huobean@gmail.com>
To: Huan Tang <tanghuan@vivo.com>, bvanassche@acm.org
Cc: James.Bottomley@HansenPartnership.com, alim.akhtar@samsung.com, 
 angelogioacchino.delregno@collabora.com, avri.altman@wdc.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org, 
 luhongfei@vivo.com, manivannan.sadhasivam@linaro.org,
 martin.petersen@oracle.com,  matthias.bgg@gmail.com,
 opensource.kernel@vivo.com, peter.wang@mediatek.com, 
 quic_nguyenb@quicinc.com, wenxing.cheng@vivo.com
Date: Wed, 21 May 2025 16:56:50 +0200
In-Reply-To: <20250521143224.587-1-tanghuan@vivo.com>
References: <b0ec5b8a-b303-4e5b-bca9-4524eba9fa31@acm.org>
	 <20250521143224.587-1-tanghuan@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTA1LTIxIGF0IDIyOjMyICswODAwLCBIdWFuIFRhbmcgd3JvdGU6Cj4gPiA+
ID4gK3N0YXRpYyBjb25zdCBjaGFyICp1ZnNfaGlkX3N0YXRlX3RvX3N0cmluZyhlbnVtIHVmc19o
aWRfc3RhdGUgc3RhdGUpCj4gPiA+ID4gK3sKPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN3aXRjaCAo
c3RhdGUpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIGNhc2UgSElEX0lETEU6Cj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuICJpZGxlIjsKPiA+ID4gPiArwqDCoMKg
wqDCoMKgIGNhc2UgQU5BTFlTSVNfSU5fUFJPR1JFU1M6Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuICJhbmFseXNpc19pbl9wcm9ncmVzcyI7Cj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoCBjYXNlIERFRlJBR19SRVFVSVJFRDoKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gImRlZnJhZ19yZXF1aXJlZCI7Cj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCBjYXNlIERFRlJBR19JTl9QUk9HUkVTUzoKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gImRlZnJhZ19pbl9wcm9ncmVzcyI7Cj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCBjYXNlIERFRlJBR19DT01QTEVURUQ6Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuICJkZWZyYWdfY29tcGxldGVkIjsKPiA+ID4gPiArwqDCoMKgwqDCoMKg
IGNhc2UgREVGUkFHX05PVF9SRVFVSVJFRDoKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gImRlZnJhZ19ub3RfcmVxdWlyZWQiOwo+ID4gPiA+ICvCoMKgwqDCoMKg
wqAgZGVmYXVsdDoKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
InVua25vd24iOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gPiA+ICt9Cj4gPiA+IAo+ID4g
PiBUaGUgZW51bSB1ZnNfaGlkX3N0YXRlIHZhbHVlcyBhcmUgY29udGlndW91cyBhbmQgc3RhcnQg
ZnJvbSAwLCBtYXliZSBjaGFuZ2Ugc3dpdGNoLXN0YXRlIHRvIDoKPiA+ID4gCj4gPiA+ICNkZWZp
bmUgTlVNX1VGU19ISURfU1RBVEVTIDYKPiA+ID4gc3RhdGljIGNvbnN0IGNoYXIgKnVmc19oaWRf
c3RhdGVzW05VTV9VRlNfSElEX1NUQVRFU10gPSB7Cj4gPiA+IMKgwqDCoCAiaWRsZSIsCj4gPiA+
IMKgwqDCoMKgICJhbmFseXNpc19pbl9wcm9ncmVzcyIsCj4gPiA+IMKgwqDCoMKgICJkZWZyYWdf
cmVxdWlyZWQiLAo+ID4gPiDCoMKgwqDCoCAiZGVmcmFnX2luX3Byb2dyZXNzIiwKPiA+ID4gwqDC
oMKgwqAgImRlZnJhZ19jb21wbGV0ZWQiLAo+ID4gPiDCoMKgwqDCoCAiZGVmcmFnX25vdF9yZXF1
aXJlZCIKPiA+ID4gfTsKPiAKPiA+IElmIHRoaXMgY2hhbmdlIGlzIG1hZGUsIHBsZWFzZSB1c2Ug
dGhlIGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXIgc3ludGF4Cj4gPiAoW2xhYmVsXSA9ICJ0ZXh0Iiku
IFRoaXMgd2lsbCBtYWtlIGl0IGVhc2llciB0byB2ZXJpZnkgdGhhdCB0aGUKPiA+IGVudW1lcmF0
aW9uIGxhYmVscyBhbmQgdGhlIHN0cmluZ3MgbWF0Y2guCj4gCj4gSGkgYmFydCBhbmQgYmVhbiBz
aXIsCj4gCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzIGFuZCBndWlkYW5jZe+8gQo+IAo+
IFdoYXQgZG8geW91IHRoaW5rIG9mIHRoZSBmb2xsb3dpbmcgY2hhbmdlcz8KPiAKPiB1ZnMuaAo+
IMKgKy8qIGJISURTdGF0ZSBhdHRyaWJ1dGUgdmFsdWVzICovwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgCj4gwqArZW51bSB1ZnNfaGlkX3N0YXRlIHvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDC
oMKgwqAgSElEX0lETEXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSAwLMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgK8KgwqDCoMKgwqDCoCBBTkFMWVNJU19JTl9QUk9H
UkVTU8KgwqDCoCA9IDEswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqArwqDCoMKg
wqDCoMKgIERFRlJBR19SRVFVSVJFRMKgwqDCoMKgwqDCoMKgwqAgPSAyLMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIAo+IMKgK8KgwqDCoMKgwqDCoCBERUZSQUdfSU5fUFJPR1JFU1PCoMKg
wqDCoMKgID0gMyzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKg
wqAgREVGUkFHX0NPTVBMRVRFRMKgwqDCoMKgwqDCoMKgID0gNCzCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqAgREVGUkFHX05PVF9SRVFVSVJFRMKgwqDCoMKg
ID0gNSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqAgTlVN
X1VGU19ISURfU1RBVEVTwqDCoMKgwqDCoCA9IDYswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgCj4gwqArfTsgCj4gCj4gdWZzLXN5c2ZzLmMKPiDCoCtzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IHVmc19oaWRfc3RhdGVzW10gPSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqAgW0hJRF9J
RExFXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gImlkbGUiLMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgCj4gwqArwqDCoMKgwqDCoMKgIFtBTkFMWVNJU19JTl9QUk9HUkVTU13CoCA9ICJhbmFseXNp
c19pbl9wcm9ncmVzcyIswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgCj4gwqArwqDCoMKgwqDCoMKgIFtERUZSQUdfUkVRVUlSRURdwqDCoMKgwqDCoMKgID0gImRl
ZnJhZ19yZXF1aXJlZCIswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIAo+IMKgK8KgwqDCoMKgwqDCoCBbREVGUkFHX0lOX1BST0dSRVNTXcKgwqDC
oCA9ICJkZWZyYWdfaW5fcHJvZ3Jlc3MiLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqAgW0RFRlJBR19DT01QTEVURURdwqDC
oMKgwqDCoCA9ICJkZWZyYWdfY29tcGxldGVkIizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgK8KgwqDCoMKgwqDCoCBbREVGUkFHX05PVF9S
RVFVSVJFRF3CoMKgID0gImRlZnJhZ19ub3RfcmVxdWlyZWQiLMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqArfTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgCj4gwqArc3RhdGljIGNvbnN0IGNoYXIgKnVmc19oaWRfc3RhdGVfdG9fc3RyaW5n
KGVudW0gdWZzX2hpZF9zdGF0ZSBzdGF0ZSnCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCt7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqAg
aWYgKHN0YXRlIDwgTlVNX1VGU19ISURfU1RBVEVTKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+
IMKgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHVmc19oaWRfc3RhdGVzW3N0
YXRlXTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAKPiDCoCvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgCj4gwqArwqDCoMKgwqDCoMKgIHJldHVybiAidW5rbm93biI7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgK30gCj4gCj4gLi4u
Cj4gCj4gK3N0YXRpYyBzc2l6ZV90IHN0YXRlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0
ciwgY2hhciAqYnVmKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHVmc19oYmEgKmhiYSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHUzMiB2YWx1ZTsKPiArwqDC
oMKgwqDCoMKgwqBpbnQgcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXQgPSBoaWRfcXVlcnlf
YXR0cihoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1JFQURfQVRUUiwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFFVRVJZX0FUVFJfSUROX0hJRF9TVEFURSwg
JnZhbHVlKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNf
ZW1pdChidWYsICIlc1xuIiwgdWZzX2hpZF9zdGF0ZV90b19zdHJpbmcodmFsdWUpKTsKPiArfQo+
IAo+IFRoYW5rcwo+IEh1YW4KPiAKPiAKPiAKCgpsb29rcyBnb29kIHRvIG1lLCB3aXRoIHRoaXMg
Y2hhbmdlLCBwbGVhc2UgYWRkIG15IHJldmlld2VkLWJ5IHRhZyBpbiB0aGUgbmV4dCB2ZXJzaW9u
LgoKS2luZCByZWdhcmRzLApCZWFuCg==


