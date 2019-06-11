Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8697B41927
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 01:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407377AbfFKXvP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 19:51:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405024AbfFKXvP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 Jun 2019 19:51:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BNoB7b155144;
        Tue, 11 Jun 2019 23:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/meZgtaPTa5PFf7KQ1Bcw9Apchd1MakO0hY9FkfTGbs=;
 b=LEUOHamgupIZLeW7GlIEm8f5Y31uFe7+WBAmnfXdyYTMyvAofQpvv1sQWZ4bGOwkYNcy
 r1JRq6ZgQjVp5JlCg7yUXR/HWmcj95F8bOQRrLTJ3iGE0eka1H920SDNK3XXDh+S3LQZ
 Xa7Wz02xJyrMK+Z58eIpAv545PC/iRblJNNtVYF95RgBKW4ClMUkxWPBFlsBBSs92s5R
 oS8IT8EqzaKKFnv88N4LDnY5XJTe8G4Bo37tIlxqC6G+xDihaHJBKdpZ1DtKc6Z/ax2i
 q9GiAnyBsaHQf8qmpkXu+SenjJnJueall8Y3mJumNhDpK86O1V35mKEZhxJEI9+qcEUK PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nqr42y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 23:50:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BNoBMo080763;
        Tue, 11 Jun 2019 23:50:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t0p9rjry5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 23:50:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5BNo4pt026972;
        Tue, 11 Jun 2019 23:50:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 16:50:04 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190610150317.29546-1-ming.lei@redhat.com>
        <20190610150317.29546-3-ming.lei@redhat.com>
        <1560191829.3698.8.camel@HansenPartnership.com>
        <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
        <1560207747.3698.30.camel@HansenPartnership.com>
        <20190611002856.GA32621@ming.t460p>
Date:   Tue, 11 Jun 2019 19:50:01 -0400
In-Reply-To: <20190611002856.GA32621@ming.t460p> (Ming Lei's message of "Tue,
        11 Jun 2019 08:28:57 +0800")
Message-ID: <yq1k1drfzrq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110155
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> 1) revert the 3 first, then re-organize the whole patchset in correct
> order(convert drivers first, then the 3 above drivers)
>
> 2) simply apply the 5 patches now
>
> Any comments?

I'm on the fence about this. Your patches were some of the first ones
that went into the 5.3 tree. So I'd have to rebase pretty much the whole
5.3 queue.

Whereas merging your updates leaves a sequence of 100+ commits that
could lead to bisection problems in the future. I'm particularly worried
about ipr and lpfc but all these drivers are actively used.

As much as I like to see all drivers, without exception, use the sg
iterators, it would have been nice to have a smoother transition.

-- 
Martin K. Petersen	Oracle Linux Engineering
