Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853B03927E
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfFGQtm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 12:49:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35266 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfFGQtm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 12:49:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57GnFwl151918;
        Fri, 7 Jun 2019 16:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=hDR9Xe/5ScJJQYCqkvNVrxuGJuQ3Cx12nQW1sMGrJa8=;
 b=mIvGrhNfZGwtWa3DJhLzqvaBzztiiJFRLZV/GZgleLn+vw5bc1OTB7Dn4F/rTb2R/V+T
 Sr44kjNcVPpWX+uH+LrBPIcxl9vc0NwMpMUzmkiLtG7V04RsT4zJ9tv42ZxArbzIypsF
 o4F+B0p3Ca/PDcGe86FRPbB+iLcZjC3zFP75dWC5jv5S+yuoHgO7xNsjE8Xoh/gN3FLo
 Tp5qDfaJuwA0Istebr1rxqr55K3J2ilRY1OMLM9DgEmIk/XVQkobNJTGS3Add3RqLQWT
 MPk074bdDxbpC/BN6izRNmiJOZnCdMYDObwbq/oUurPMX5NRGkIvfNrYrdWLt1FMFzf1 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qya5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 16:49:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57GmcnQ078658;
        Fri, 7 Jun 2019 16:49:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2swnhbe7d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 16:49:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57GncWl030197;
        Fri, 7 Jun 2019 16:49:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 09:49:38 -0700
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        linux-scsi@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Subject: Re: [V3 00/10] mpt3sas: Aero/Sea HBA feature addition
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
        <yq1r285jwmg.fsf@oracle.com>
        <3bbff3d0ec462217333a34a2f416ec51@mail.gmail.com>
Date:   Fri, 07 Jun 2019 12:49:35 -0400
In-Reply-To: <3bbff3d0ec462217333a34a2f416ec51@mail.gmail.com> (Kashyap
        Desai's message of "Fri, 7 Jun 2019 21:10:14 +0530")
Message-ID: <yq11s05jq74.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070112
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Kashyap,

> AMD EPYC is not efficient w.r.t QPI transaction.
[...]
> Same test on Intel architecture provides better result

Heuristics are always hard.

However, you are making assumptions based on observed performance of
current Intel offerings vs. current AMD offerings. This results in what
is inevitably going to be a short-lived heuristic in the kernel. Things
could easily be reversed in next generation platforms from these
vendors.

So while I appreciate that the logic works given the machines you are
currently testing, I think CPU manufacturer is a horrible heuristic. You
are stating "This will be the right choice for all future processors
manufactured by Intel". That's a bit of a leap of faith.

Instead of predicting the future I prefer to make decisions based on
things we know. Measured negative impact on current EPYC family, for
instance. That's a fairly well-defined and narrow scope.

That said, I am still not a big fan of platform-specific tweaks in
drivers. While I prefer the kernel to do the right thing out of the box,
I think the module parameter is probably the better choice in this case.

-- 
Martin K. Petersen	Oracle Linux Engineering
