Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0477080A
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Aug 2023 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjHDSiJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Aug 2023 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjHDShV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Aug 2023 14:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C045581
        for <linux-scsi@vger.kernel.org>; Fri,  4 Aug 2023 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691174161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEtu9Pc0bKgiKdY8qnZ3ztu1lHt0tJndiBUgO2rbWQQ=;
        b=B7h4WxTOqz8IwCwV5Fe9/z31lQK7w3tNj8dXfwmAt/u1/mLMFGZSUvvcl5+iswgw3s4rtR
        wrYKjMVH76f8KDK2uE0SE2jQhR83OwUFBcLzHC3fppfPlVuLCUlemLdM6y1fj9Hsym79DF
        E28HsShRW4N9JkMfcgUFwxw1McPINkA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-zQyTci39OWiuzxYbA82P2g-1; Fri, 04 Aug 2023 14:35:59 -0400
X-MC-Unique: zQyTci39OWiuzxYbA82P2g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63d1695e445so24689866d6.2
        for <linux-scsi@vger.kernel.org>; Fri, 04 Aug 2023 11:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174159; x=1691778959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEtu9Pc0bKgiKdY8qnZ3ztu1lHt0tJndiBUgO2rbWQQ=;
        b=hmfLKstIE4/MwfNOEH67mJdloB6m0+LF4XdoIEMBF5BQZzslboRxhp7U5DI2cYtdq1
         gPou7MFK8EimHjUyDp2xbB4O28jUxoLXTItM0gIfxD5wm+OulV8fiXToNxig4ZUrGffC
         RHViCo4j/PwR6jv6IhnaCGvEZzWTqgv0ywXbeXCx0HmLArIdJAjJDEk0VGkn2+v8vCHt
         FGRCgtK9op7Vq+qZuJ4csb39QN4WcwBTdFCPY5YlXzERR+gG51xy5YanwXXkNwTBuJcu
         0igBPNi1L+W+R86z1YLo0AYVGNa1/dShTm8bUJH2Mybu027BaUvMkzrEOR3gjNkqCtkY
         DYFw==
X-Gm-Message-State: AOJu0Yw77aePfv3DEfABb0bbfYtj2uOW/yxygbjs+5LbZhZGBfVuC0rn
        lIa/Ut2iANDSoLmC8X6PrcaTGpfDRZ4Yo+CPB+LXLltpEoD7k5ctBFwmW5GfzPLIxAtVr7c/LFd
        uMahoKDv4gBN9sxKHxFmnkA==
X-Received: by 2002:a05:6214:5856:b0:63d:eef:c3f6 with SMTP id ml22-20020a056214585600b0063d0eefc3f6mr2316906qvb.38.1691174159052;
        Fri, 04 Aug 2023 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEExihQFif3WLaW6xvlGqNCtqhR8MrmCx3jAXvDjDY+nEncsELup5r2yfzA3OjMk6I8Lok+5w==
X-Received: by 2002:a05:6214:5856:b0:63d:eef:c3f6 with SMTP id ml22-20020a056214585600b0063d0eefc3f6mr2316890qvb.38.1691174158670;
        Fri, 04 Aug 2023 11:35:58 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a038700b00767db6f47bbsm822731qkm.73.2023.08.04.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:35:58 -0700 (PDT)
Message-ID: <eaa72e829f22478d0bc49e5c5c47583d8cca6d2b.camel@redhat.com>
Subject: Re: [PATCH 2/2] qla2xxx: allow 32 bytes CDB
From:   Laurence Oberman <loberman@redhat.com>
To:     Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        agurumurthy@marvell.com, sdeodhar@marvell.com
Date:   Fri, 04 Aug 2023 14:35:57 -0400
In-Reply-To: <c4d5c5cbcaf0298072b0e2ce2e3bc3dba123b472.camel@redhat.com>
References: <20230804071944.27214-1-njavali@marvell.com>
         <20230804071944.27214-3-njavali@marvell.com>
         <6315de061cf6f8b076d111634fe142c59c4a7e11.camel@redhat.com>
         <c4d5c5cbcaf0298072b0e2ce2e3bc3dba123b472.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDEzOjUxIC0wNDAwLCBMYXVyZW5jZSBPYmVybWFuIHdyb3Rl
Ogo+IE9uIEZyaSwgMjAyMy0wOC0wNCBhdCAxMjo1OCAtMDQwMCwgTGF1cmVuY2UgT2Jlcm1hbiB3
cm90ZToKPiA+IE9uIEZyaSwgMjAyMy0wOC0wNCBhdCAxMjo0OSArMDUzMCwgTmlsZXNoIEphdmFs
aSB3cm90ZToKPiA+ID4gRnJvbTogUXVpbm4gVHJhbiA8cXV0cmFuQG1hcnZlbGwuY29tPgo+ID4g
PiAKPiA+ID4gU3lzdGVtIGNyYXNoIHdoZW4gMzIgYnl0ZXMgQ0RCIHdhcyBzZW50IHRvIGEgbm9u
IFQxMC1QSSBkaXNrLAo+ID4gPiAKPiA+ID4gW8KgIDE3Ny4xNDMyNzldwqAgPyBxbGEyeHh4X2Rp
Zl9zdGFydF9zY3NpX21xKzB4Y2Q4LzB4Y2UwIFtxbGEyeHh4XQo+ID4gPiBbwqAgMTc3LjE0OTE2
NV3CoCA/IGludGVybmFsX2FkZF90aW1lcisweDQyLzB4NzAKPiA+ID4gW8KgIDE3Ny4xNTMzNzJd
wqAgcWxhMnh4eF9tcXVldWVjb21tYW5kKzB4MjA3LzB4MmIwIFtxbGEyeHh4XQo+ID4gPiBbwqAg
MTc3LjE1ODczMF3CoCBzY3NpX3F1ZXVlX3JxKzB4MmI3LzB4YzAwCj4gPiA+IFvCoCAxNzcuMTYy
NTAxXcKgIGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KzB4M2VhLzB4N2UwCj4gPiA+IAo+ID4gPiBD
dXJyZW50IGNvZGUgYXR0ZW1wdCB0byB1c2UgQ1JDIElPQ0IgdG8gc2VuZCB0aGUgY29tbWFuZCBi
dXQKPiA+ID4gZmFpbGVkLgo+ID4gPiBJbnN0ZWFkLCB0eXBlIDYgSU9DQiBzaG91bGQgYmUgdXNl
ZCB0byBzZW5kIHRoZSBJTy4KPiA+ID4gCj4gPiA+IENsb25lIGV4aXN0aW5nIHR5cGUgNiBJT0NC
IGNvZGUgd2l0aCBhZGRpdGlvbiBvZiBNUSBzdXBwb3J0Cj4gPiA+IHRvIGFsbG93IDMyIGJ5dGVz
IENEQiB0byBnbyB0aHJvdWdoLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogUXVpbm4gVHJh
biA8cXV0cmFuQG1hcnZlbGwuY29tPgo+ID4gPiBDYzogTGF1cmVuY2UgT2Jlcm1hbiA8bG9iZXJt
YW5AcmVkaGF0LmNvbT4KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gU2ln
bmVkLW9mZi1ieTogTmlsZXNoIEphdmFsaSA8bmphdmFsaUBtYXJ2ZWxsLmNvbT4KPiA+ID4gLS0t
Cj4gPiA+IMKgZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2lvY2IuYyB8IDI3MAo+ID4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiDCoGRyaXZlcnMvc2NzaS9xbGEyeHh4
L3FsYV9ueC5owqDCoCB8wqDCoCA0ICstCj4gPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyNzMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmMKPiA+ID4gYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9x
bGFfaW9jYi5jCj4gPiA+IGluZGV4IDBjYWE2NGE3ZGYyNi4uZTk5ZWJmN2UxYzdhIDEwMDY0NAo+
ID4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW9jYi5jCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmMKPiA+ID4gQEAgLTExLDYgKzExLDcgQEAKPiA+
ID4gwqAKPiA+ID4gwqAjaW5jbHVkZSA8c2NzaS9zY3NpX3RjcS5oPgo+ID4gPiDCoAo+ID4gPiAr
c3RhdGljIGludCBxbGFfc3RhcnRfc2NzaV90eXBlNihzcmJfdCAqc3ApOwo+ID4gPiDCoC8qKgo+
ID4gPiDCoCAqIHFsYTJ4MDBfZ2V0X2NtZF9kaXJlY3Rpb24oKSAtIERldGVybWluZSBjb250cm9s
X2ZsYWcgZGF0YQo+ID4gPiBkaXJlY3Rpb24uCj4gPiA+IMKgICogQHNwOiBTQ1NJIGNvbW1hbmQK
PiA+ID4gQEAgLTE3MjEsNiArMTcyMiw4IEBAIHFsYTI0eHhfZGlmX3N0YXJ0X3Njc2koc3JiX3Qg
KnNwKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHNjc2lfZ2V0X3Byb3Rfb3AoY21kKSA9PSBT
Q1NJX1BST1RfTk9STUFMKSB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNtZC0+Y21kX2xlbiA8PSAxNikKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHFsYTI0eHhfc3RhcnRfc2NzaShzcCk7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHFsYV9zdGFydF9zY3NpX3R5
cGU2KHNwKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gwqAKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoC8qIFNldHVwIGRldmljZSBwb2ludGVycy4gKi8KPiA+ID4gQEAgLTIxMDAsNiArMjEw
Myw4IEBAIHFsYTJ4eHhfZGlmX3N0YXJ0X3Njc2lfbXEoc3JiX3QgKnNwKQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKHNjc2lfZ2V0X3Byb3Rfb3AoY21kKSA9PSBTQ1NJX1BST1RfTk9STUFMKSB7
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNtZC0+Y21kX2xlbiA8
PSAxNikKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHFsYTJ4eHhfc3RhcnRfc2NzaV9tcShzcCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHFsYV9zdGFydF9zY3NpX3R5cGU2KHNwKTsKPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gwqAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9j
a19pcnFzYXZlKCZxcGFpci0+cXBfbG9jaywgZmxhZ3MpOwo+ID4gPiBAQCAtNDIwNSwzICs0MjEw
LDI2OCBAQCBxbGEyeDAwX3N0YXJ0X2JpZGlyKHNyYl90ICpzcCwgc3RydWN0Cj4gPiA+IHNjc2lf
cWxhX2hvc3QgKnZoYSwgdWludDMyX3QgdG90X2RzZHMpCj4gPiA+IMKgCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcnZhbDsKPiA+ID4gwqB9Cj4gPiA+ICsKPiA+ID4gKy8qKgo+ID4gPiAr
ICogcWxhX3N0YXJ0X3Njc2lfdHlwZTYoKSAtIFNlbmQgYSBTQ1NJIGNvbW1hbmQgdG8gdGhlIElT
UAo+ID4gPiArICogQHNwOiBjb21tYW5kIHRvIHNlbmQgdG8gdGhlIElTUAo+ID4gPiArICoKPiA+
ID4gKyAqIFJldHVybnMgbm9uLXplcm8gaWYgYSBmYWlsdXJlIG9jY3VycmVkLCBlbHNlIHplcm8u
Cj4gPiA+ICsgKi8KPiA+ID4gK3N0YXRpYyBpbnQKPiA+ID4gK3FsYV9zdGFydF9zY3NpX3R5cGU2
KHNyYl90ICpzcCkKPiA+ID4gK3sKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBuc2VnOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nwqDC
oCBmbGFnczsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgdWludDMyX3TCoMKgwqDCoMKgwqDCoMKgKmNs
cl9wdHI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoGhhbmRs
ZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGNtZF90eXBlXzYgKmNtZF9wa3Q7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoHVpbnQxNl90wqDCoMKgwqDCoMKgwqDCoGNudDsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgdWludDE2X3TCoMKgwqDCoMKgwqDCoMKgcmVxX2NudDsKPiA+ID4gK8KgwqDCoMKg
wqDCoMKgdWludDE2X3TCoMKgwqDCoMKgwqDCoMKgdG90X2RzZHM7Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCByZXFfcXVlICpyZXEgPSBOVUxMOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgcnNwX3F1ZSAqcnNwOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2NzaV9jbW5kICpj
bWQgPSBHRVRfQ01EX1NQKHNwKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHNjc2lfcWxh
X2hvc3QgKnZoYSA9IHNwLT5mY3BvcnQtPnZoYTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IHFsYV9od19kYXRhICpoYSA9IHZoYS0+aHc7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBx
bGFfcXBhaXIgKnFwYWlyID0gc3AtPnFwYWlyOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB1aW50MTZf
dCBtb3JlX2RzZF9saXN0cyA9IDA7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkc2RfZG1h
ICpkc2RfcHRyOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB1aW50MTZfdCBpOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqBfX2JlMzIgKmZjcF9kbDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgdWludDhfdCBhZGRp
dGlvbmFsX2NkYl9sZW47Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjdDZfZHNkICpjdHg7
Cj4gPiA+ICsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBBY3F1aXJlIHFwYWlyIHNw
ZWNpZmljIGxvY2sgKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrX2lycXNhdmUoJnFw
YWlyLT5xcF9sb2NrLCBmbGFncyk7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogU2V0
dXAgcXBhaXIgcG9pbnRlcnMgKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmVxID0gcXBhaXItPnJl
cTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgcnNwID0gcXBhaXItPnJzcDsKPiA+ID4gKwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqAvKiBTbyB3ZSBrbm93IHdlIGhhdmVuJ3QgcGNpX21hcCdlZCBhbnl0aGlu
ZyB5ZXQgKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgdG90X2RzZHMgPSAwOwo+ID4gPiArCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoC8qIFNlbmQgbWFya2VyIGlmIHJlcXVpcmVkICovCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoGlmICh2aGEtPm1hcmtlcl9uZWVkZWQgIT0gMCkgewo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKF9fcWxhMngwMF9tYXJrZXIodmhhLCBxcGFpciwgMCwg
MCwKPiA+ID4gTUtfU1lOQ19BTEwpCj4gPiA+ICE9IFFMQV9TVUNDRVNTKSB7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmcXBhaXItPnFwX2xvY2ssCj4gPiA+IGZsYWdzKTsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUUxBX0ZVTkNUSU9OX0ZB
SUxFRDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZoYS0+bWFya2VyX25lZWRlZCA9IDA7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoH0KPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBoYW5kbGUgPSBxbGEy
eHh4X2dldF9uZXh0X2hhbmRsZShyZXEpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoaGFuZGxl
ID09IDApCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHF1ZXVpbmdf
ZXJyb3I7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogTWFwIHRoZSBzZyB0YWJsZSBz
byB3ZSBoYXZlIGFuIGFjY3VyYXRlIGNvdW50IG9mIHNnCj4gPiA+IGVudHJpZXMgbmVlZGVkICov
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChzY3NpX3NnX2NvdW50KGNtZCkpIHsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5zZWcgPSBkbWFfbWFwX3NnKCZoYS0+cGRldi0+
ZGV2LAo+ID4gPiBzY3NpX3NnbGlzdChjbWQpLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY3NpX3NnX2NvdW50
KGNtZCksIGNtZC0KPiA+ID4gPiBzY19kYXRhX2RpcmVjdGlvbik7Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHkoIW5zZWcpKQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcXVldWluZ19lcnJvcjsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoG5zZWcgPSAwOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICsKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgdG90X2RzZHMgPSBuc2VnOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoC8qIGV2ZW50aG91Z2ggZHJpdmVyIG9ubHkgbmVlZCAxIFQ2IElPQ0IsIEZXIHN0aWxsCj4g
PiA+IGNvbnZlcnQKPiA+ID4gRFNEIHRvIENvbnRpbnVlYXRpb24gSU9DQiAqLwo+ID4gPiArwqDC
oMKgwqDCoMKgwqByZXFfY250ID0gcWxhMjR4eF9jYWxjX2lvY2JzKHZoYSwgdG90X2RzZHMpOwo+
ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHNwLT5pb3Jlcy5yZXNfdHlwZSA9IFJFU09VUkNF
X0lPQ0IgfCBSRVNPVVJDRV9FWENIOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzcC0+aW9yZXMuZXhj
aF9jbnQgPSAxOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBzcC0+aW9yZXMuaW9jYl9jbnQgPSByZXFf
Y250Owo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChxbGFfZ2V0X2Z3X3Jlc291cmNl
cyhzcC0+cXBhaXIsICZzcC0+aW9yZXMpKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBxdWV1aW5nX2Vycm9yOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoG1v
cmVfZHNkX2xpc3RzID0gcWxhMjR4eF9jYWxjX2RzZF9saXN0cyh0b3RfZHNkcyk7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGlmICgobW9yZV9kc2RfbGlzdHMgKyBxcGFpci0+ZHNkX2ludXNlKSA+PSBO
VU1fRFNEX0NIQUlOKQo+ID4gPiB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBxbF9kYmcocWxfZGJnX2lvLCB2aGEsIDB4MzAyOCwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTnVtIG9mIERTRCBsaXN0ICVkIGlzIHRoYW4gJWQg
Zm9yCj4gPiA+IGNtZD0lcC5cbiIsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbW9yZV9kc2RfbGlzdHMgKyBxcGFpci0+ZHNkX2ludXNlLAo+ID4gPiBO
VU1fRFNEX0NIQUlOLCBjbWQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBxdWV1aW5nX2Vycm9yOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICsKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKG1vcmVfZHNkX2xpc3RzIDw9IHFwYWlyLT5kc2RfYXZhaWwpCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHN1ZmZpY2llbnRfZHNkczsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgZWxzZQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbW9yZV9kc2RfbGlzdHMgLT0gcXBhaXItPmRzZF9hdmFpbDsKPiA+ID4gKwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgbW9yZV9kc2RfbGlzdHM7IGkrKykgewo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHNkX3B0ciA9IGt6YWxsb2Moc2l6ZW9m
KCpkc2RfcHRyKSwgR0ZQX0FUT01JQyk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoIWRzZF9wdHIpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBxbF9sb2cocWxfbG9nX2ZhdGFsLCB2aGEsIDB4MzAyOSwKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkZh
aWxlZCB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yCj4gPiA+IGRzZF9kbWEKPiA+ID4gZm9yIGNtZD0l
cC5cbiIsIGNtZCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byBxdWV1aW5nX2Vycm9yOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSU5JVF9MSVNU
X0hFQUQoJmRzZF9wdHItPmxpc3QpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkc2RfcHRyLT5kc2RfYWRkciA9IGRtYV9wb29sX2FsbG9jKGhhLQo+ID4gPiA+
ZGxfZG1hX3Bvb2wsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgR0ZQX0FUT01JQywgJmRzZF9wdHItPmRzZF9saXN0X2RtYSk7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWRzZF9wdHItPmRzZF9hZGRyKSB7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUoZHNk
X3B0cik7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcWxfbG9nKHFsX2xvZ19mYXRhbCwgdmhhLCAweDMwMmEsCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gYWxsb2Nh
dGUgbWVtb3J5IGZvcgo+ID4gPiBkc2RfYWRkcgo+ID4gPiBmb3IgY21kPSVwLlxuIiwgY21kKTsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IHF1ZXVpbmdfZXJyb3I7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsaXN0X2FkZF90YWlsKCZkc2RfcHRy
LT5saXN0LCAmcXBhaXItPmRzZF9saXN0KTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHFwYWlyLT5kc2RfYXZhaWwrKzsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gPiAr
Cj4gPiA+ICtzdWZmaWNpZW50X2RzZHM6Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHJlcV9jbnQgPSAx
Owo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXEtPmNudCA8IChyZXFfY250ICsg
MikpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19TSEFET1df
UkVHX0NBUEFCTEUoaGEpKSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY250ID0gKnJlcS0+b3V0X3B0cjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY250ID0gKHVpbnQxNl90KXJkX3JlZ19kd29yZF9yZWxheGVk
KHJlcS0KPiA+ID4gPiByZXFfcV9vdXQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmCj4gPiA+IChxbGEyeDAwX2NoZWNrX3JlZzE2X2Zvcl9k
aXNjb25uZWN0KHZoYSwKPiA+ID4gY250KSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBxdWV1aW5nX2Vycm9y
Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiArCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVxLT5yaW5nX2luZGV4IDwgY250KQo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlcS0+
Y250ID0gY250IC0gcmVxLT5yaW5nX2luZGV4Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZWxzZQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJlcS0+Y250ID0gcmVxLT5sZW5ndGggLSAocmVxLT5yaW5nX2luZGV4Cj4gPiA+
IC0KPiA+ID4gY250KTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXEtPmNudCA8IChyZXFfY250ICsgMikpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBxdWV1aW5nX2Vycm9yOwo+ID4gPiArwqDCoMKgwqDC
oMKgwqB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgY3R4ID0gJnNwLT51LnNjbWQuY3Q2
X2N0eDsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBtZW1zZXQoY3R4LCAwLCBzaXplb2Yo
c3RydWN0IGN0Nl9kc2QpKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgY3R4LT5mY3BfY21uZCA9IGRt
YV9wb29sX3phbGxvYyhoYS0+ZmNwX2NtbmRfZG1hX3Bvb2wsCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBHRlBfQVRPTUlDLCAmY3R4LT5mY3BfY21uZF9kbWEpOwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBpZiAoIWN0eC0+ZmNwX2NtbmQpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHFsX2xvZyhxbF9sb2dfZmF0YWwsIHZoYSwgMHgzMDMxLAo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gYWxsb2NhdGUg
ZmNwX2NtbmQgZm9yIGNtZD0lcC5cbiIsCj4gPiA+IGNtZCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIHF1ZXVpbmdfZXJyb3I7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oH0KPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBJbml0aWFsaXplIHRoZSBEU0QgbGlz
dCBhbmQgZG1hIGhhbmRsZSAqLwo+ID4gPiArwqDCoMKgwqDCoMKgwqBJTklUX0xJU1RfSEVBRCgm
Y3R4LT5kc2RfbGlzdCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGN0eC0+ZHNkX3VzZV9jbnQgPSAw
Owo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChjbWQtPmNtZF9sZW4gPiAxNikgewo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRkaXRpb25hbF9jZGJfbGVuID0g
Y21kLT5jbWRfbGVuIC0gMTY7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoY21kLT5jbWRfbGVuICUgNCB8fAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNtZC0+Y21kX2xlbiA+IFFMQV9DREJfQlVGX1NJWkUpIHsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBTQ1NJIGNvbW1hbmQg
YmlnZ2VyIHRoYW4gMTYgYnl0ZXMgbXVzdAo+ID4gPiBiZQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG11bHRpcGxlIG9mIDQgb3IgdG9vIGJp
Zy4KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBx
bF9sb2cocWxfbG9nX3dhcm4sIHZoYSwgMHgzMDMzLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic2NzaSBjbWQgbGVuICVkIG5vdCBt
dWx0aXBsZSBvZiA0Cj4gPiA+IGZvcgo+ID4gPiBjbWQ9JXAuXG4iLAo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQtPmNtZF9sZW4s
IGNtZCk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBxdWV1aW5nX2Vycm9yX2ZjcF9jbW5kOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3R4LT5m
Y3BfY21uZF9sZW4gPSAxMiArIGNtZC0+Y21kX2xlbiArIDQ7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oH0gZWxzZSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZGRpdGlvbmFs
X2NkYl9sZW4gPSAwOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3R4LT5m
Y3BfY21uZF9sZW4gPSAxMiArIDE2ICsgNDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gPiAr
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qIEJ1aWxkIGNvbW1hbmQgcGFja2V0LiAqLwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqByZXEtPmN1cnJlbnRfb3V0c3RhbmRpbmdfY21kID0gaGFuZGxlOwo+ID4g
PiArwqDCoMKgwqDCoMKgwqByZXEtPm91dHN0YW5kaW5nX2NtZHNbaGFuZGxlXSA9IHNwOwo+ID4g
PiArwqDCoMKgwqDCoMKgwqBzcC0+aGFuZGxlID0gaGFuZGxlOwo+ID4gPiArwqDCoMKgwqDCoMKg
wqBjbWQtPmhvc3Rfc2NyaWJibGUgPSAodW5zaWduZWQgY2hhciAqKSh1bnNpZ25lZAo+ID4gPiBs
b25nKWhhbmRsZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmVxLT5jbnQgLT0gcmVxX2NudDsKPiA+
ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBjbWRfcGt0ID0gKHN0cnVjdCBjbWRfdHlwZV82ICop
cmVxLT5yaW5nX3B0cjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgY21kX3BrdC0+aGFuZGxlID0gbWFr
ZV9oYW5kbGUocmVxLT5pZCwgaGFuZGxlKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqAv
KiBaZXJvIG91dCByZW1haW5pbmcgcG9ydGlvbiBvZiBwYWNrZXQuICovCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoC8qwqDCoMKgIHRhZ2dlZCBxdWV1aW5nIG1vZGlmaWVyIC0tIGRlZmF1bHQgaXMgVFNL
X1NJTVBMRQo+ID4gPiAoMCkuCj4gPiA+ICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNscl9wdHIg
PSAodWludDMyX3QgKiljbWRfcGt0ICsgMjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgbWVtc2V0KGNs
cl9wdHIsIDAsIFJFUVVFU1RfRU5UUllfU0laRSAtIDgpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBj
bWRfcGt0LT5kc2VnX2NvdW50ID0gY3B1X3RvX2xlMTYodG90X2RzZHMpOwo+ID4gPiArCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoC8qIFNldCBOUE9SVC1JRCBhbmQgTFVOIG51bWJlciovCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGNtZF9wa3QtPm5wb3J0X2hhbmRsZSA9IGNwdV90b19sZTE2KHNwLT5mY3Bv
cnQtPmxvb3BfaWQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBjbWRfcGt0LT5wb3J0X2lkWzBdID0g
c3AtPmZjcG9ydC0+ZF9pZC5iLmFsX3BhOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBjbWRfcGt0LT5w
b3J0X2lkWzFdID0gc3AtPmZjcG9ydC0+ZF9pZC5iLmFyZWE7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oGNtZF9wa3QtPnBvcnRfaWRbMl0gPSBzcC0+ZmNwb3J0LT5kX2lkLmIuZG9tYWluOwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBjbWRfcGt0LT52cF9pbmRleCA9IHNwLT52aGEtPnZwX2lkeDsKPiA+ID4g
Kwo+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBCdWlsZCBJT0NCIHNlZ21lbnRzICovCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoHFsYTI0eHhfYnVpbGRfc2NzaV90eXBlXzZfaW9jYnMoc3AsIGNtZF9wa3Qs
IHRvdF9kc2RzKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnRfdG9fc2NzaWx1bihj
bWQtPmRldmljZS0+bHVuLCAmY21kX3BrdC0+bHVuKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaG9z
dF90b19mY3Bfc3dhcCgodWludDhfdCAqKSZjbWRfcGt0LT5sdW4sCj4gPiA+IHNpemVvZihjbWRf
cGt0LQo+ID4gPiA+IGx1bikpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qIGJ1aWxk
IEZDUF9DTU5EIElVICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGludF90b19zY3NpbHVuKGNtZC0+
ZGV2aWNlLT5sdW4sICZjdHgtPmZjcF9jbW5kLT5sdW4pOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBj
dHgtPmZjcF9jbW5kLT5hZGRpdGlvbmFsX2NkYl9sZW4gPSBhZGRpdGlvbmFsX2NkYl9sZW47Cj4g
PiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGNtZC0+c2NfZGF0YV9kaXJlY3Rpb24gPT0g
RE1BX1RPX0RFVklDRSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN0eC0+
ZmNwX2NtbmQtPmFkZGl0aW9uYWxfY2RiX2xlbiB8PSAxOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBl
bHNlIGlmIChjbWQtPnNjX2RhdGFfZGlyZWN0aW9uID09IERNQV9GUk9NX0RFVklDRSkKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN0eC0+ZmNwX2NtbmQtPmFkZGl0aW9uYWxf
Y2RiX2xlbiB8PSAyOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFBvcHVsYXRlIHRo
ZSBGQ1BfUFJJTy4gKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGhhLT5mbGFncy5mY3BfcHJp
b19lbmFibGVkKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3R4LT5mY3Bf
Y21uZC0+dGFza19hdHRyaWJ1dGUgfD0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzcC0+ZmNwb3J0LT5mY3BfcHJpbyA8PCAzOwo+ID4gPiArCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoG1lbWNweShjdHgtPmZjcF9jbW5kLT5jZGIsIGNtZC0+Y21uZCwgY21kLT5jbWRf
bGVuKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBmY3BfZGwgPSAoX19iZTMyICopKGN0
eC0+ZmNwX2NtbmQtPmNkYiArIDE2ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZGl0
aW9uYWxfY2RiX2xlbik7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoCpmY3BfZGwgPSBodG9ubCgodWlu
dDMyX3Qpc2NzaV9idWZmbGVuKGNtZCkpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNt
ZF9wa3QtPmZjcF9jbW5kX2RzZWdfbGVuID0gY3B1X3RvX2xlMTYoY3R4LQo+ID4gPiA+IGZjcF9j
bW5kX2xlbik7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHB1dF91bmFsaWduZWRfbGU2NChjdHgtPmZj
cF9jbW5kX2RtYSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZjbWRfcGt0LT5mY3BfY21uZF9kc2VnX2FkZHJlc3MpOwo+ID4gPiArCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoHNwLT5mbGFncyB8PSBTUkJfRkNQX0NNTkRfRE1BX1ZBTElEOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqBjbWRfcGt0LT5ieXRlX2NvdW50ID0KPiA+ID4gY3B1X3RvX2xl
MzIoKHVpbnQzMl90KXNjc2lfYnVmZmxlbihjbWQpKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyog
U2V0IHRvdGFsIGRhdGEgc2VnbWVudCBjb3VudC4gKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY21k
X3BrdC0+ZW50cnlfY291bnQgPSAodWludDhfdClyZXFfY250Owo+ID4gPiArCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoHdtYigpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBBZGp1c3QgcmluZyBpbmRl
eC4gKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmVxLT5yaW5nX2luZGV4Kys7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChyZXEtPnJpbmdfaW5kZXggPT0gcmVxLT5sZW5ndGgpIHsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlcS0+cmluZ19pbmRleCA9IDA7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXEtPnJpbmdfcHRyID0gcmVxLT5yaW5nOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVxLT5yaW5nX3B0cisrOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgc3AtPnFwYWlyLT5jbWRfY250Kys7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoHNwLT5mbGFncyB8PSBTUkJfRE1BX1ZBTElEOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoC8qIFNldCBjaGlwIG5ldyByaW5nIGluZGV4LiAqLwo+ID4gPiArwqDCoMKgwqDCoMKg
wqB3cnRfcmVnX2R3b3JkKHJlcS0+cmVxX3FfaW4sIHJlcS0+cmluZ19pbmRleCk7Cj4gPiA+ICsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogTWFuYWdlIHVucHJvY2Vzc2VkIFJJTy9aSU8gY29tbWFu
ZHMgaW4gcmVzcG9uc2UgcXVldWUuCj4gPiA+ICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICh2
aGEtPmZsYWdzLnByb2Nlc3NfcmVzcG9uc2VfcXVldWUgJiYKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHJzcC0+cmluZ19wdHItPnNpZ25hdHVyZSAhPSBSRVNQT05TRV9QUk9DRVNTRUQpCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBxbGEyNHh4X3Byb2Nlc3NfcmVzcG9u
c2VfcXVldWUodmhhLCByc3ApOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnFwYWlyLT5xcF9sb2NrLCBmbGFncyk7Cj4gPiA+ICsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIFFMQV9TVUNDRVNTOwo+ID4gPiArCj4gPiA+ICtxdWV1aW5nX2Vy
cm9yX2ZjcF9jbW5kOgo+ID4gPiArwqDCoMKgwqDCoMKgwqBkbWFfcG9vbF9mcmVlKGhhLT5mY3Bf
Y21uZF9kbWFfcG9vbCwgY3R4LT5mY3BfY21uZCwgY3R4LQo+ID4gPiA+IGZjcF9jbW5kX2RtYSk7
Cj4gPiA+ICsKPiA+ID4gK3F1ZXVpbmdfZXJyb3I6Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICh0
b3RfZHNkcykKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNjc2lfZG1hX3Vu
bWFwKGNtZCk7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgcWxhX3B1dF9md19yZXNvdXJj
ZXMoc3AtPnFwYWlyLCAmc3AtPmlvcmVzKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBp
ZiAoc3AtPnUuc2NtZC5jcmNfY3R4KSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBtZW1wb29sX2ZyZWUoc3AtPnUuc2NtZC5jcmNfY3R4LCBoYS0KPiA+ID4gPmN0eF9tZW1w
b29sKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwLT51LnNjbWQuY3Jj
X2N0eCA9IE5VTEw7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ID4gKwo+ID4gPiArwqDCoMKg
wqDCoMKgwqBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxcGFpci0+cXBfbG9jaywgZmxhZ3MpOwo+
ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBRTEFfRlVOQ1RJT05fRkFJTEVEOwo+
ID4gPiArfQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX254LmgK
PiA+ID4gYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnguaAo+ID4gPiBpbmRleCA2ZGM4MGM4
ZGRmNzkuLjVkMWJkYzE1Yjc1YyAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9zY3NpL3FsYTJ4
eHgvcWxhX254LmgKPiA+ID4gKysrIGIvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX254LmgKPiA+
ID4gQEAgLTg1Nyw3ICs4NTcsOSBAQCBzdHJ1Y3QgZmNwX2NtbmQgewo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgdWludDhfdCB0YXNrX2F0dHJpYnV0ZTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHVpbnQ4
X3QgdGFza19tYW5hZ2VtZW50Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdWludDhfdCBhZGRpdGlv
bmFsX2NkYl9sZW47Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoHVpbnQ4X3QgY2RiWzI2MF07IC8qIDI1
NiBmb3IgQ0RCIGxlbiBhbmQgNCBmb3IgRkNQX0RMICovCj4gPiA+ICsjZGVmaW5lIFFMQV9DREJf
QlVGX1NJWkXCoCAyNTYKPiA+ID4gKyNkZWZpbmUgUUxBX0ZDUF9ETF9TSVpFwqDCoCA0Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoHVpbnQ4X3QgY2RiW1FMQV9DREJfQlVGX1NJWkUgKyBRTEFfRkNQX0RM
X1NJWkVdOyAvKiAyNTYKPiA+ID4gZm9yCj4gPiA+IENEQiBsZW4gYW5kIDQgZm9yIEZDUF9ETCAq
Lwo+ID4gPiDCoH07Cj4gPiA+IMKgCj4gPiA+IMKgc3RydWN0IGRzZF9kbWEgewo+ID4gCj4gPiBR
VCBhbmQgTmlsZXNoLCBUaGFuayB5b3UuCj4gPiBJIG5lZWQgbW9yZSB0aW1lIHRvIGxvb2sgYXQg
dGhpcyBmdWxseSBidXQgSSB3aWxsIGdldCBpdCB0ZXN0ZWQgaW4KPiA+IHRoZQo+ID4gbWVhbnRp
bWUuIAo+ID4gSSB3aWxsIHJlcGx5IHdpdGggYSByZXZpZXcgb3IgcXVlc3Rpb25zIGxhdGVyLgo+
ID4gCj4gPiBUaGFua3MgZm9yIHNlbmRpbmcgdGhpcwo+ID4gTGF1cmVuY2UKPiAKPiBAUVQgYW5k
IE5pbGVzaAo+IFdoaWNoIGtlcm5lbCB3YXMgdGhpcyBhZ2FpbnN0Lgo+IERpZCB5b3UgZ3V5cyB0
ZXN0IHRoaXMgb25seSBhZ2FpbnMgeW91ciBkcml2ZXIgb3IgYWxzbyB1cHN0cmVhbQo+IEkgY2Fu
bm90IGJ1aWxkIGl0IGNsZWFuIGJlY2F1c2UgVGhlcmUgaXMgbm8gc3RydWN0dXJlIG1lbWJlcgo+
IGRzZF9pbnVzZQo+IAo+IENhbiB5b3Ugc2VuZCBvbmUgZm9yIHVwc3RyZWFtIHBsZWFzZQo+IAo+
IFBhdGNoIGFwcGxpZWQgZmluZSB0byA2LjUtcmM0Cj4gCj4gW2xvYmVybWFuQHNlZ3N0b3JhZ2Uz
IGxpbnV4XSQgcGF0Y2ggLXAxIDwgcXQucGF0Y2ggCj4gcGF0Y2hpbmcgZmlsZSBkcml2ZXJzL3Nj
c2kvcWxhMnh4eC9xbGFfaW9jYi5jCj4gSHVuayAjMiBzdWNjZWVkZWQgYXQgMTcxOCAob2Zmc2V0
IC00IGxpbmVzKS4KPiBIdW5rICMzIHN1Y2NlZWRlZCBhdCAyMDk5IChvZmZzZXQgLTQgbGluZXMp
Lgo+IEh1bmsgIzQgc3VjY2VlZGVkIGF0IDQxNzkgKG9mZnNldCAtMzEgbGluZXMpLgo+IHBhdGNo
aW5nIGZpbGUgZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX254LmgKPiAKPiAKPiBCdWlsZCBmYWls
cwo+IAo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmM6IEluIGZ1bmN0aW9uIOKAmHFs
YV9zdGFydF9zY3NpX3R5cGU24oCZOgo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmM6
NDI2MDoyOTogZXJyb3I6IOKAmHN0cnVjdCBxbGFfcXBhaXLigJkKPiBoYXMKPiBubyBtZW1iZXIg
bmFtZWQg4oCYZHNkX2ludXNl4oCZCj4gwqAgaWYgKChtb3JlX2RzZF9saXN0cyArIHFwYWlyLT5k
c2RfaW51c2UpID49IE5VTV9EU0RfQ0hBSU4pIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefgo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4
L3FsYV9pb2NiLmM6NDI2MzozMjogZXJyb3I6IOKAmHN0cnVjdCBxbGFfcXBhaXLigJkKPiBoYXMK
PiBubyBtZW1iZXIgbmFtZWQg4oCYZHNkX2ludXNl4oCZCj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1v
cmVfZHNkX2xpc3RzICsgcXBhaXItPmRzZF9pbnVzZSwgTlVNX0RTRF9DSEFJTiwgY21kKTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBefgo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmM6NDI2NzoyOTogZXJyb3I6
IOKAmHN0cnVjdCBxbGFfcXBhaXLigJkKPiBoYXMKPiBubyBtZW1iZXIgbmFtZWQg4oCYZHNkX2F2
YWls4oCZCj4gwqAgaWYgKG1vcmVfZHNkX2xpc3RzIDw9IHFwYWlyLT5kc2RfYXZhaWwpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn4K
PiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW9jYi5jOjQyNzA6MjY6IGVycm9yOiDigJhzdHJ1
Y3QgcWxhX3FwYWly4oCZCj4gaGFzCj4gbm8gbWVtYmVyIG5hbWVkIOKAmGRzZF9hdmFpbOKAmQo+
IMKgwqAgbW9yZV9kc2RfbGlzdHMgLT0gcXBhaXItPmRzZF9hdmFpbDsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefgo+IGRyaXZlcnMvc2NzaS9x
bGEyeHh4L3FsYV9pb2NiLmM6NDI4OTo0MTogZXJyb3I6IOKAmHN0cnVjdCBxbGFfcXBhaXLigJkK
PiBoYXMKPiBubyBtZW1iZXIgbmFtZWQg4oCYZHNkX2xpc3TigJk7IGRpZCB5b3UgbWVhbiDigJho
aW50c19saXN04oCZPwo+IMKgwqAgbGlzdF9hZGRfdGFpbCgmZHNkX3B0ci0+bGlzdCwgJnFwYWly
LT5kc2RfbGlzdCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn4KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBoaW50c19saXN0Cj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2lv
Y2IuYzo0MjkwOjg6IGVycm9yOiDigJhzdHJ1Y3QgcWxhX3FwYWly4oCZIGhhcwo+IG5vIG1lbWJl
ciBuYW1lZCDigJhkc2RfYXZhaWzigJkKPiDCoMKgIHFwYWlyLT5kc2RfYXZhaWwrKzsKCkkgc2Vl
IHdoZXJlIHRoaXMgd2FzIGRvbmUsIHRoZXJlIGFyZSB0d28gbW9yZSBwYXRjaGVzClNvIEkgd2ls
bCBhZGQgdGhvc2UgYW5kIHRlc3QgCltQQVRDSCAxLzJdIHFsYTJ4eHg6IE1vdmUgcmVzb3VyY2Ug
dG8gYWxsb3cgY29kZSByZXVzZQo+IAoK

