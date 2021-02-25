Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8560325866
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Feb 2021 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBYVIa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Feb 2021 16:08:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234891AbhBYVGs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Feb 2021 16:06:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PL4Lxv166532;
        Thu, 25 Feb 2021 16:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pqOo7IEXZuN4o2GJtHjkXskjvWSpvNljjvnukPmdQyc=;
 b=Et7Jb1Xw5qUZjYtE1oWTeQpGjEs7bT+ZKyRBuhpLtFZ4/57LbkEdVaRdKixq90JVYmp4
 O2/7vgBOEuwIWSqXnJrTrbU9lLq95N86iS0bJ9tl/zSI1N0KLuYVu26Ii8tkD3fHwgHG
 dYS6zO8Zju/FGnPamkvcVxSj6YwRCsaXyLHg0VAduhJqwZfe6i+P7nuHfFTiFSAt3Aek
 +GYKAFl/w+Q/zni/yIZ/M21XqLglRJo4WeVXthQ0dmu6yUMcI77EDFqM1LG+kCzZSTvJ
 VL8dRWaj6iPOeVIYcl8m26HPCIbj89N3OtjlNNK58QBESu/Xyyl8rtJn6pdtjRRoCZ7b WQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xh8jv328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:05:37 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PL26iH021277;
        Thu, 25 Feb 2021 21:05:36 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 36tt29hnmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 21:05:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PL5ZKw33030518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 21:05:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1879AE060;
        Thu, 25 Feb 2021 21:05:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA767AE05F;
        Thu, 25 Feb 2021 21:05:34 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.211.123.159])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 21:05:34 +0000 (GMT)
Subject: Re: [PATCH v2 4/5] ibmvfc: store return code of H_FREE_SUB_CRQ during
 cleanup
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com
References: <20210225204824.14570-1-tyreld@linux.ibm.com>
 <20210225204824.14570-5-tyreld@linux.ibm.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Message-ID: <46ef110f-238e-50bf-731a-ba3a4392dba6@linux.vnet.ibm.com>
Date:   Thu, 25 Feb 2021 15:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225204824.14570-5-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_14:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250161
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

