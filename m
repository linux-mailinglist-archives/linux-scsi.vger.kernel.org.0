Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2295234E51
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Aug 2020 01:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGaXRM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 Jul 2020 19:17:12 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:63105 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgGaXRM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 Jul 2020 19:17:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596237430; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Type: MIME-Version: Sender;
 bh=1zsJhq/goG5jxNbt1w2QIRo86ReaWeQ6QGLznVlr6Jk=; b=lz98SC0u/J/t0okJYxrcYKTqfSF/zZabwQFLWHF2UIyVrode7uCSfIUS2tsSCtpk/pGqkgAE
 nC4v5Zw4f4bN5nElJFdIFyfWBR/+Qp/ufl3SfTRJIq1jm1o5oTaQryyQJ/VCPEJ/FgUdi3bG
 4V5mgUeRFBU36UAjcTNBW02t4No=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f24a676e7a13aa2041a72e2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 23:17:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2CA68C433B1; Fri, 31 Jul 2020 23:17:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF5A5C433CA;
        Fri, 31 Jul 2020 23:17:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5c3e63ea4c7ecc7e8e595b7c9d9d7f3e"
Date:   Sat, 01 Aug 2020 07:17:08 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Avri Altman <Avri.Altman@wdc.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com
Subject: Re: [PATCH v4] scsi: ufs: Cleanup completed request without interrupt
 notification
In-Reply-To: <f45c6c47-ffc5-3f8e-3234-9e5989dbf996@acm.org>
References: <20200724140246.19434-1-stanley.chu@mediatek.com>
 <SN6PR04MB4640B5FC06968244DDACB8BEFC720@SN6PR04MB4640.namprd04.prod.outlook.com>
 <1596159018.17247.53.camel@mtkswgap22>
 <97f1dfb0-41b6-0249-3e82-cae480b0efb6@acm.org>
 <8b0a158a7c3ee2165e09290996521ffc@codeaurora.org>
 <f45c6c47-ffc5-3f8e-3234-9e5989dbf996@acm.org>
Message-ID: <548b602daa1e15415625cb8d1f81a208@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=_5c3e63ea4c7ecc7e8e595b7c9d9d7f3e
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hi Bart,

On 2020-08-01 00:51, Bart Van Assche wrote:
> On 2020-07-31 01:00, Can Guo wrote:
>> AFAIK, sychronization of scsi_done is not a problem here, because scsi
>> layer
>> use the atomic state, namely SCMD_STATE_COMPLETE, of a scsi cmd to 
>> prevent
>> the concurrency of abort and real completion of it.
>> 
>> Check func scsi_times_out(), hope it helps.
>> 
>> enum blk_eh_timer_return scsi_times_out(struct request *req)
>> {
>> ...
>>         if (rtn == BLK_EH_DONE) {
>>                 /*
>>                  * Set the command to complete first in order to 
>> prevent
>> a real
>>                  * completion from releasing the command while error
>> handling
>>                  * is using it. If the command was already completed,
>> then the
>>                  * lower level driver beat the timeout handler, and it
>> is safe
>>                  * to return without escalating error recovery.
>>                  *
>>                  * If timeout handling lost the race to a real
>> completion, the
>>                  * block layer may ignore that due to a fake timeout
>> injection,
>>                  * so return RESET_TIMER to allow error handling 
>> another
>> shot
>>                  * at this command.
>>                  */
>>                 if (test_and_set_bit(SCMD_STATE_COMPLETE, 
>> &scmd->state))
>>                         return BLK_EH_RESET_TIMER;
>>                 if (scsi_abort_command(scmd) != SUCCESS) {
>>                         set_host_byte(scmd, DID_TIME_OUT);
>>                         scsi_eh_scmd_add(scmd);
>>                 }
>>         }
>> }
> 
> I am familiar with this mechanism. My concern is that both the regular
> completion path and the abort handler must call scsi_dma_unmap() before
> calling cmd->scsi_done(cmd). I don't see how
> test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state) could prevent that
> the regular completion path and the abort handler call scsi_dma_unmap()
> concurrently since both calls happen before the SCMD_STATE_COMPLETE bit
> is set?
> 
> Thanks,
> 
> Bart.

For scsi_dma_unmap() part, that is true - we should make it serialized 
with
any other completion paths. I've found it during my fault injection 
test, so
I've made a patch to fix it, but it only comes in my next error recovery
enhancement patch series. Please check the attachment.

Thanks,

Can Guo.


--=_5c3e63ea4c7ecc7e8e595b7c9d9d7f3e
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=0005-scsi-ufs-Properly-release-resources-if-a-task-is-abo.patch
Content-Disposition: attachment;
 filename=0005-scsi-ufs-Properly-release-resources-if-a-task-is-abo.patch;
 size=1473

RnJvbSBlZjg3ODMyYjVmNmZmNmFmMjlhYzliYWM3ZmRlYTFlMjQ1YzgxNjJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYW4gR3VvIDxjYW5nQGNvZGVhdXJvcmEub3JnPgpEYXRlOiBT
dW4sIDcgSnVuIDIwMjAgMTI6MTY6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIIDUvNl0gc2NzaTog
dWZzOiBQcm9wZXJseSByZWxlYXNlIHJlc291cmNlcyBpZiBhIHRhc2sgaXMKIGFib3J0ZWQgc3Vj
Y2Vzc2Z1bGx5CgpJbiBjdXJyZW50IFVGUyB0YXNrIGFib3J0IGhvb2ssIG5hbWVseSB1ZnNoY2Rf
YWJvcnQoKSwgaWYgYSB0YXNrIGlzCmFib3J0ZWQgc3VjY2Vzc2Z1bGx5LCBjbG9jayBzY2FsaW5n
IGJ1c3kgdGltZSBzdGF0aXN0aWNzIGlzIG5vdCB1cGRhdGVkCmFuZCwgbW9zdCBpbXBvcnRhbnQs
IGNsa19nYXRpbmcuYWN0aXZlX3JlcXMgaXMgbm90IGRlY3JlYXNlZCwgd2hpY2ggbWFrZXMKY2xr
X2dhdGluZy5hY3RpdmVfcmVxcyBzdGF5IGFib3ZlIHplcm8gZm9yZXZlciwgbWVhbmluZyBjbG9j
ayBnYXRpbmcgd291bGQKbmV2ZXIgaGFwcGVuLiBUbyBmaXggaXQsIGluc3RlYWQgb2YgcmVsZWFz
aW5nIHJlc291cmNlcyAibWFubnVhbGx5IiwgdXNlCnRoZSBleGlzdGluZyBmdW5jIF9fdWZzaGNk
X3RyYW5zZmVyX3JlcV9jb21wbCgpLgoKQ2hhbmdlLUlkOiBJYThjYzQ5NmY1M2JiNDI4ZWFjN2Nm
YTc4NGU0MzFhMmIzN2E0NTM3NQpTaWduZWQtb2ZmLWJ5OiBDYW4gR3VvIDxjYW5nQGNvZGVhdXJv
cmEub3JnPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5jCmluZGV4IDNjNDZmNzQuLjg3YjkxMWYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMKKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYwpA
QCAtNjg3NiwxNiArNjg3NiwxMCBAQCBzdGF0aWMgaW50IHVmc2hjZF9hYm9ydChzdHJ1Y3Qgc2Nz
aV9jbW5kICpjbWQpCiAJCWdvdG8gb3V0OwogCX0KIAotCXNjc2lfZG1hX3VubWFwKGNtZCk7Ci0K
IAlzcGluX2xvY2tfaXJxc2F2ZShob3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsKLQl1ZnNoY2Rfb3V0
c3RhbmRpbmdfcmVxX2NsZWFyKGhiYSwgdGFnKTsKLQloYmEtPmxyYlt0YWddLmNtZCA9IE5VTEw7
CisJX191ZnNoY2RfdHJhbnNmZXJfcmVxX2NvbXBsKGhiYSwgKDFVTCA8PCB0YWcpKTsKIAlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKGhvc3QtPmhvc3RfbG9jaywgZmxhZ3MpOwogCi0JY2xlYXJfYml0
X3VubG9jayh0YWcsICZoYmEtPmxyYl9pbl91c2UpOwotCXdha2VfdXAoJmhiYS0+ZGV2X2NtZC50
YWdfd3EpOwotCiBvdXQ6CiAJaWYgKCFlcnIpIHsKIAkJZXJyID0gU1VDQ0VTUzsKLS0gClF1YWxj
b21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgbWVtYmVyIG9mIENvZGUgQXVyb3JhIEZv
cnVtLCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2ZSBQcm9qZWN0LgoK
--=_5c3e63ea4c7ecc7e8e595b7c9d9d7f3e--
