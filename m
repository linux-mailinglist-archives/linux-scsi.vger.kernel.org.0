Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F007AFB86
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Sep 2023 08:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjI0G55 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Sep 2023 02:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjI0G5z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Sep 2023 02:57:55 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52916D6;
        Tue, 26 Sep 2023 23:57:51 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:56:31
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:56:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] aic7xxx: Clean up errors in aic7xxx_inline.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <34038f6a.87a.18ad56cccfe.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4g0hNl6+y9AA--.573W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOgABsT
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
cmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCgpT
aWduZWQtb2ZmLWJ5OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2
ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4X2lubGluZS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L2FpYzd4eHgvYWljN3h4eF9pbmxpbmUuaCBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHhf
aW5saW5lLmgKaW5kZXggMGI1N2I3ODNlZjQxLi5lZWY1OGI4NGE3NTAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHhfaW5saW5lLmgKKysrIGIvZHJpdmVycy9zY3NpL2Fp
Yzd4eHgvYWljN3h4eF9pbmxpbmUuaApAQCAtNTksNyArNTksNyBAQCBzdGF0aWMgaW5saW5lIGNo
YXIgKmFoY19uYW1lKHN0cnVjdCBhaGNfc29mdGMgKmFoYyk7CiAKIHN0YXRpYyBpbmxpbmUgY2hh
ciAqYWhjX25hbWUoc3RydWN0IGFoY19zb2Z0YyAqYWhjKQogewotCXJldHVybiAoYWhjLT5uYW1l
KTsKKwlyZXR1cm4gYWhjLT5uYW1lOwogfQogCiAvKioqKioqKioqKioqKioqKioqKioqKiogTWlz
Y2VsbGFuZW91cyBTdXBwb3J0IEZ1bmN0aW9ucyAqKioqKioqKioqKioqKioqKioqKioqKi8KLS0g
CjIuMTcuMQo=
