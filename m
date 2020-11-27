Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264E2C6ACF
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Nov 2020 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgK0RqY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Nov 2020 12:46:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56404 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729305AbgK0RqY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Nov 2020 12:46:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ARHVT48003770;
        Fri, 27 Nov 2020 12:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pqOo7IEXZuN4o2GJtHjkXskjvWSpvNljjvnukPmdQyc=;
 b=KVzaEIxc+//Qh7tcyG+M/HrzJUQ4MWjkJsQmVksRG9BuEfAEU0apYsEsBK/IqVSIgJHn
 ZucyPoqLoXBoRui/ywyLfBuxq43iEHD3Wju/HqhXinGk2hzoGzHvFrSQGuHksyQLaNyA
 yArWsInlTwVWac4Z4d7cK99in+Mqse2qAiHxrirc92jXvdHjlSrtsZdHgV0WqTC7rLG3
 2k3bQrg5e4mlKfqcx8Q/ZD+Y2HynSCvxd+6MjE2CFO+PL27DFXP2n7F8WxEVjAMVOLzo
 ktks01SBiLDr3xKLY9N4YdQ25bcbq7lvynOR76VTkpKFMNELKIyuGwQE7RAZGV0Cda12 yA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3535b9h5m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 12:46:16 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ARHgC6M017144;
        Fri, 27 Nov 2020 17:46:15 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 351uh8jny0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 17:46:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ARHk78C13435584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 17:46:07 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D417C6057;
        Fri, 27 Nov 2020 17:46:14 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2140C6055;
        Fri, 27 Nov 2020 17:46:13 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.163.79.105])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Nov 2020 17:46:13 +0000 (GMT)
Subject: Re: [PATCH 03/13] ibmvfc: add Subordinate CRQ definitions
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com
References: <20201126014824.123831-1-tyreld@linux.ibm.com>
 <20201126014824.123831-4-tyreld@linux.ibm.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Message-ID: <30ab86cd-be61-e3e7-8c12-1ab24292ddb6@linux.vnet.ibm.com>
Date:   Fri, 27 Nov 2020 11:46:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201126014824.123831-4-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_10:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=997 mlxscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270099
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

