Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1A2FCAA0
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Jan 2021 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhATFN0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Jan 2021 00:13:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54718 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbhATFGM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Jan 2021 00:06:12 -0500
X-UUID: ae8c506c935b41ecb212d9fba57f7932-20210120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=n24ZuMOFK1TgRFTdXpEtNt2gYwalLdEuHvd3JI+ijyY=;
        b=XvsdIhJiHkLarAKnZ+UgvzQe65reRX2XqILhil0ElkOBByNiGgLr5q8lXf4CfSopfM+r5ef2Dv9TZ+OGhp+DqIiO8ciC8jAzt3houyTrHhasBphCCyQpoe/IVaJGjcqMWDzfCSRooR2q/owS8JPfZ/Ina8OPCzgq1pDwDArGuUU=;
X-UUID: ae8c506c935b41ecb212d9fba57f7932-20210120
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1853810859; Wed, 20 Jan 2021 13:05:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Jan 2021 13:05:15 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jan 2021 13:05:15 +0800
Message-ID: <1611119115.1261.5.camel@mtkswgap22>
Subject: Re: [PATCH v10 2/3] scsi: ufs: Refactor
 ufshcd_init/exit_clk_scaling/gating()
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <asutoshd@codeaurora.org>, <nguyenb@codeaurora.org>,
        <hongwus@codeaurora.org>, <ziqichen@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Satya Tangirala" <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Jan 2021 13:05:15 +0800
In-Reply-To: <1611057183-6925-3-git-send-email-cang@codeaurora.org>
References: <1611057183-6925-1-git-send-email-cang@codeaurora.org>
         <1611057183-6925-3-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQ2FuLA0KDQpPbiBUdWUsIDIwMjEtMDEtMTkgYXQgMDM6NTMgLTA4MDAsIENhbiBHdW8gd3Jv
dGU6DQo+IHVmc2hjZF9oYmFfZXhpdCgpIGlzIGFsd2F5cyBjYWxsZWQgYWZ0ZXIgdWZzaGNkX2V4
aXRfY2xrX3NjYWxpbmcoKSBhbmQNCj4gdWZzaGNkX2V4aXRfY2xrX2dhdGluZygpLCBzbyBtb3Zl
IHVmc2hjZF9leGl0X2Nsa19zY2FsaW5nL2dhdGluZygpIHRvDQo+IHVmc2hjZF9oYmFfZXhpdCgp
LiBNZWFud2hpbGUsIGFkZCBkZWRpY2F0ZWQgZnVuY3MgdG8gaW5pdCBhbmQgcmVtb3ZlDQo+IHN5
c2ZzIG5vZGVzIG9mIGNsb2NrIHNjYWxpbmcvZ2F0aW5nIHRvIG1ha2UgdGhlIGNvZGUgbW9yZSBy
ZWFkYWJsZS4NCj4gT3ZlcmFsbCBmdW5jdGlvbmFsaXR5IHJlbWFpbnMgc2FtZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENhbiBHdW8gPGNhbmdAY29kZWF1cm9yYS5vcmc+DQoNCkxvb2tzIGdvb2Qg
dG8gbWUuDQoNCkJUVywgRllJLiB0aGlzIHNlcmllcyBoYXMgY29uZmxpY3RzIGR1cmluZyB0aGUg
bWVyZ2UgdG8gdGhlIGxhdGVzdA0KZm9yLW5leHQgYnJhbmNoIGluIE1hcnRpbidzIHRyZWUuDQoN
ClJldmlld2VkLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KDQoN
Cg0K

