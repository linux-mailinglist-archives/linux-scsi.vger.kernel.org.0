Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F094AF7E
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFSBdW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 21:33:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFSBdV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 21:33:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J1T0wJ121858;
        Wed, 19 Jun 2019 01:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=n8TIPfQLWTPUjisF013djjcWdTeLLfpH9UXmAZNDSbU=;
 b=OLr0TLYppLI24kwY9x1Axxb89iiYPFD3QH939Uhh3t0nlIWF8ae+yDwbHaPbYN9v+je1
 2EhY4RtwtUVxv4V/wEny95tVy3I+5eMvNqYQYA4EMeqNQXlPLVWPIm75fcPzeZTYkVvw
 Bj5ygeCkZGdfKIO6KWhieKtIYI/772II9xWP9PD+zq3qFC+xaYYJYp+/AtZH6+d74IkJ
 j/oRNNCz2tz8j3gPb+2bhaQbs1lpWTqbvrON04wJmsCIil3PIY+lkrXaxTM17PxQ4HzX
 tExA524L8NKbuFZhXlwJjwpPR6vKpxArjyYl0eSqyph/kQCiqPtN07PfIUEE1dEpvpVJ cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t78098hx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:32:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J1VdGU162985;
        Wed, 19 Jun 2019 01:32:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t77ymt6h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:32:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J1WrPS001562;
        Wed, 19 Jun 2019 01:32:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:32:52 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 0/3] Avoid that .queuecommand() gets called for a quiesced SCSI device
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190617151820.241583-1-bvanassche@acm.org>
Date:   Tue, 18 Jun 2019 21:32:50 -0400
In-Reply-To: <20190617151820.241583-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Mon, 17 Jun 2019 08:18:17 -0700")
Message-ID: <yq136k6xsu5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=745 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> As explained in a recent LSF/MM topic proposal, it can happen that the
> SCSI error handler calls .queuecommand() for a blocked SCSI
> device. SCSI LLDs do not expect this. Hence this patch series. Please
> consider this series for kernel v5.3.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
